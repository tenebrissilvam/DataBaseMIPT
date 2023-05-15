import os
import pytest
from . import execute_sql_to_df
from . import read_sql


@pytest.fixture()
def select_script():
    path = os.getenv("SCRIPT_PATH")
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select_script
    )


def test(select_df):
    assert select_df.query("table_name == 'medicine'")['cnt'].iloc[0] == 14
    assert select_df.query("table_name == 'animal'")['cnt'].iloc[0] == 66
    assert select_df.query("table_name == 'provisions'")['cnt'].iloc[0] == 89-79
    assert select_df.query("table_name == 'appliance'")['cnt'].iloc[0] == 99-89
    assert select_df.query("table_name == 'bedroom'")['cnt'].iloc[0] == 179-99
    assert select_df.query("table_name == 'person'")['cnt'].iloc[0] == 499-179
    assert select_df.query("table_name == 'task'")['cnt'].iloc[0] == 539-499
    assert select_df.query("table_name == 'actual_task'")['cnt'].iloc[0] == 478-424
    assert select_df.query("table_name == 'task_history'")['cnt'].iloc[0] == 415-404
    assert select_df.query("table_name == 'sleep_schedule'")['cnt'].iloc[0] == 455-444