Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B937F483
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 10:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhEMI6U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 04:58:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:35571 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhEMI6T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 04:58:19 -0400
IronPort-SDR: 4fN7iFgejAxJySbwOmkiQMWchUw66iMQ6TEnp4gFDx+tryBPF4ae01laQfaQcoLlmAF6MirHcE
 YIGkDZhvxA1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="261152189"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="261152189"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:57:08 -0700
IronPort-SDR: ogjvyMBaS7hJxTgzTfHj/rJSru07AIpL+12N6gLVnLt7seKvo+fJJ2rmp2D+0DoBkBmMezecYB
 7Ft/q33Ur5rw==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625927982"
Received: from hongyuni-mobl1.ccr.corp.intel.com (HELO [10.238.1.57]) ([10.238.1.57])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:57:06 -0700
Subject: Re: [tip: sched/core] sched/fair: Add a few assertions
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org
References: <20210422123308.015639083@infradead.org>
 <162081530827.29796.4612627849821173058.tip-bot2@tip-bot2>
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Message-ID: <532b693a-3699-b3db-f61f-3c8596d8b006@linux.intel.com>
Date:   Thu, 13 May 2021 16:56:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <162081530827.29796.4612627849821173058.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


On 2021/5/12 18:28, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     9099a14708ce1dfecb6002605594a0daa319b555
> Gitweb:        https://git.kernel.org/tip/9099a14708ce1dfecb6002605594a0daa319b555
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 17 Nov 2020 18:19:35 -05:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 12 May 2021 11:43:26 +02:00
> 
> sched/fair: Add a few assertions
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Don Hiatt <dhiatt@digitalocean.com>
> Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lkml.kernel.org/r/20210422123308.015639083@infradead.org
> ---
>  kernel/sched/fair.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Add quick test results based on tip tree sched/core merge commit:

====TEST INFO====
- kernel under test:
	-- tip tree sched/core merge: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=60208dac643e24cbc62317de4e486fdcbbf05215
	-- coresched_v10 kernel source: https://github.com/digitalocean/linux-coresched/commits/coresched/v10-v5.10.y

- test machine setup: 
	CPU(s):              192
	On-line CPU(s) list: 0-191
	Thread(s) per core:  2
	Core(s) per socket:  48
	Socket(s):           2
	NUMA node(s):        4

- performance test workloads: 
	-- A. sysbench cpu (192 threads) + sysbench cpu (192 threads)
	-- B. sysbench cpu (192 threads) + sysbench mysql (192 threads)
	-- C. uperf netperf.xml (192 threads over TCP or UDP protocol separately)
	-- D. will-it-scale context_switch via pipe (192 threads)

- negative test:
	-- A. continuously toggle coresched (enable/disable) thru prctl on task cookies of PGID, during full loading of uperf workload with coresched on
	-- B. continuously toggle smt (on/off) via /sys/devices/system/cpu/smt/control, during full loading of uperf workload with coresched on

====TEST RESULTS====
- performance change key info:
	--workload B: coresched (cs_on), sysbench mysql performance drop around 20% vs coresched_v10
	--workload C, coresched (cs_on), uperf performance increased almost double vs coresched_v10
	--workload C, default (cs_off), uperf performance drop over 25% vs coresched_v10, same issue seen on v5.13-rc1 base (w/o coresched patchset)
	--workload D, coresched (cs_on), wis performance increased almost double vs coresched_v10

- negative test summary:
	no platform hang or kernel panic observed for both test

- performance info of workloads, normalized based on coresched_v10 results
	-- performance workload A:
	Note: 
	* no performance change compared to coresched_v10
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
|                                       | **   | coresched_tip_merge_base_v5.13-rc1   | coresched_tip_merge_base_v5.13-rc1     | **    | coresched_v10_base_v5.10.11   | coresched_v10_base_v5.10.11     |
+=======================================+======+======================================+========================================+=======+===============================+=================================+
| workload                              | **   | sysbench cpu * 192                   | sysbench cpu * 192                     | **    | sysbench cpu * 192            | sysbench cpu * 192              |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| prctl/cgroup                          | **   | prctl on workload cpu_0              | prctl on workload cpu_1                | **    | cg_sysbench_cpu_0             | cg_sysbench_cpu_1               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| record_item                           | **   | Tput_avg (events/s)                  | Tput_avg (events/s)                    | **    | Tput_avg (events/s)           | Tput_avg (events/s)             |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| coresched normalized vs coresched_v10 | **   | 0.97                                 | 1.05                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| default normalized vs coresched_v10   | **   | 1.03                                 | 0.95                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| smtoff normalized vs coresched_v10    | **   | 0.96                                 | 1.04                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+


	-- performance workload B:
	Note: 
	* coresched (cs_on), sysbench mysql performance drop around 20% vs coresched_v10
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
|                                       | **   | coresched_tip_merge_base_v5.13-rc1   | coresched_tip_merge_base_v5.13-rc1     | **    | coresched_v10_base_v5.10.11   | coresched_v10_base_v5.10.11     |
+=======================================+======+======================================+========================================+=======+===============================+=================================+
| workload                              | **   | sysbench cpu * 192                   | sysbench mysql * 192                   | **    | sysbench cpu * 192            | sysbench mysql * 192            |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| prctl/cgroup                          | **   | prctl on workload cpu_0              | prctl on workload mysql_0              | **    | cg_sysbench_cpu_0             | cg_sysbench_mysql_0             |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| record_item                           | **   | Tput_avg (events/s)                  | Tput_avg (events/s)                    | **    | Tput_avg (events/s)           | Tput_avg (events/s)             |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| coresched normalized vs coresched_v10 | **   | 1.02                                 | 0.81                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| default normalized vs coresched_v10   | **   | 1.01                                 | 0.94                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| smtoff normalized vs coresched_v10    | **   | 0.93                                 | 1.18                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+


	-- performance workload C:
	Note: 
	* coresched (cs_on), uperf performance increased almost double vs coresched_v10
	* default (cs_off), uperf performance drop over 25% vs coresched_v10, same issue seen on v5.13-rc1 base (w/o coresched patchset)
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
|                                       | **   | coresched_tip_merge_base_v5.13-rc1   | coresched_tip_merge_base_v5.13-rc1     | **    | coresched_v10_base_v5.10.11   | coresched_v10_base_v5.10.11     |
+=======================================+======+======================================+========================================+=======+===============================+=================================+
| workload                              | **   | uperf netperf TCP * 192              | uperf netperf UDP * 192                | **    | uperf netperf TCP * 192       | uperf netperf UDP * 192         |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| prctl/cgroup                          | **   | prctl on workload uperf              | prctl on workload uperf                | **    | cg_uperf                      | cg_uperf                        |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| record_item                           | **   | Tput_avg (Gb/s)                      | Tput_avg (Gb/s)                        | **    | Tput_avg (Gb/s)               | Tput_avg (Gb/s)                 |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| coresched normalized vs coresched_v10 | **   | 1.83                                 | 1.93                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| default normalized vs coresched_v10   | **   | 0.75                                 | 0.71                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+
| smtoff normalized vs coresched_v10    | **   | 1                                    | 1.06                                   | **    | 1                             | 1                               |
+---------------------------------------+------+--------------------------------------+----------------------------------------+-------+-------------------------------+---------------------------------+


	-- performance workload D:
	Note: 
	* coresched (cs_on), wis performance increased almost double vs coresched_v10
	* default (cs_off) and smtoff, wis performance is better vs coresched_v10
+---------------------------------------+------+--------------------------------------+-------+-------------------------------+
|                                       | **   | coresched_tip_merge_base_v5.13-rc1   | **    | coresched_v10_base_v5.10.11   |
+=======================================+======+======================================+=======+===============================+
| workload                              | **   | will-it-scale  * 192                 | **    | will-it-scale  * 192          |
|                                       |      | (pipe based context_switch)          |       | (pipe based context_switch)   |
+---------------------------------------+------+--------------------------------------+-------+-------------------------------+
| prctl/cgroup                          | **   | prctl on workload wis                | **    | cg_wis                        |
+---------------------------------------+------+--------------------------------------+-------+-------------------------------+
| record_item                           | **   | threads_avg                          | **    | threads_avg                   |
+---------------------------------------+------+--------------------------------------+-------+-------------------------------+
| coresched normalized vs coresched_v10 | **   | 2.01                                 | **    | 1.00                          |
+---------------------------------------+------+--------------------------------------+-------+-------------------------------+
| default normalized vs coresched_v10   | **   | 1.13                                 | **    | 1.00                          |
+---------------------------------------+------+--------------------------------------+-------+-------------------------------+
| smtoff normalized vs coresched_v10    | **   | 1.29                                 | **    | 1.00                          |
+---------------------------------------+------+--------------------------------------+-------+-------------------------------+


	-- notes on record_item:
	* coresched normalized vs coresched_v10: smton, cs enabled, test result normalized by result of coresched_v10 under same config
	* default normalized vs coresched_v10: smton, cs disabled, test result normalized by result of coresched_v10 under same config
	* smtoff normalized vs coresched_v10: smtoff, test result normalized by result of coresched_v10 under same config



-- Hongyu Ning
