﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Data.SqlClient;
using static Abrigo_Final_BD.Abrigo;

namespace Abrigo_Final_BD
{
    public partial class Historial : Form
    {
        public static string SQLConnectionString = "Data Source = (localdb)\\Abrigo_Final_DB;Initial Catalog=master;Integrated Security=True;Encrypt=False";
        private SqlConnection CN;

        public Historial()
        {
            InitializeComponent();
            CN = ConnectionManager.getSGBDConnection();
        }

        public static class ConnectionManager
        {
            public static SqlConnection getSGBDConnection()
            {
                return new SqlConnection(SQLConnectionString);
            }
        }

        private void adicionar_historial_Click(object sender, EventArgs e)
        {
            try
            {
                CN.Open();

                foreach (Control ctrl in this.Controls)
                {
                    if (ctrl is TextBox textBox)
                    {
                        // Verificar se o TextBox está vazio e se o nome não é "Origem_Historia"
                        if (textBox.Text.Length == 0)
                        {

                            MessageBox.Show($"Campos obrigatório(*) não preenchidos", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                            break;
                        }
                    }
                }

                DateTime horarioDateTime;
                if (!DateTime.TryParse(data_intervencao.Text, out horarioDateTime) && data_intervencao.Text.Length > 0)
                {
                    MessageBox.Show("Formato de horário inválido. Por favor, insira uma data válida. (Ex: 2024-05-27 12:30:45)", "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }


                int num_chegada_animal = Convert.ToInt32(num_animal.Text);
                if (!find_animal(num_chegada_animal))
                {
                    MessageBox.Show("Animal com número de chegada não econtrado  " + num_chegada_animal + " não está registado na nossa base de dados", "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error); ;
                    return;
                }


                SqlCommand cmd = new SqlCommand("INSERT INTO Projeto_Historial_Clinico (Historial_Clinico_data, Patologia, Medicacao,Num_Chegada) VALUES (@data, @patologia, @medicacao,@num)", CN);

                cmd.Parameters.AddWithValue("@data", Convert.ToDateTime(data_intervencao.Text));
                cmd.Parameters.AddWithValue("@patologia", tipo_patologia.Text);
                cmd.Parameters.AddWithValue("@medicacao", tipo_medicacao.Text);
                cmd.Parameters.AddWithValue("@num", num_chegada_animal);

                cmd.ExecuteNonQuery();



                MessageBox.Show("Historial adicionado com sucesso!", "Sucesso", MessageBoxButtons.OK, MessageBoxIcon.Information);

                //Ir para a página principal
                this.Hide();
                Abrigo abrigo = new Abrigo();
                abrigo.Show();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Erro ao adicionar historial clínico: " + ex.Message, "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                CN.Close();
            }
        }

        private bool find_animal(int animal)
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Projeto_Animal WHERE Num_chegada = @animal", CN);
            cmd.Parameters.AddWithValue("@animal", animal);

            SqlDataReader reader = cmd.ExecuteReader();
            if (!reader.HasRows)
            {
                reader.Close();
                return false;
            }
            reader.Close();
            return true;
        }

        private void voltar_atras_Click(object sender, EventArgs e)
        {
            this.Hide();
            Servicos servicos = new Servicos();
            servicos.Show();
        }

      
    }
}
