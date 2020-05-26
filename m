Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23BDA19E3E2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Apr 2020 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDDIoO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Apr 2020 04:44:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41521 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDDImA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNC-0000z4-73; Sat, 04 Apr 2020 10:41:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB36F1C0493;
        Sat,  4 Apr 2020 10:41:44 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:44 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script: Add --show-cgroup-events option
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200325124536.2800725-10-namhyung@kernel.org>
References: <20200325124536.2800725-10-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <158598970455.28353.2995259969187721305.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     160d4af97b831c87e680c607c639d55ae027087f
Gitweb:        https://git.kernel.org/tip/160d4af97b831c87e680c607c639d55ae027087f
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 25 Mar 2020 21:45:36 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf script: Add --show-cgroup-events option

The --show-cgroup-events option is to print CGROUP events in the
output like others.

Committer testing:

  [root@seventh ~]# perf record --all-cgroups --namespaces /wb/cgtest
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.039 MB perf.data (487 samples) ]
  [root@seventh ~]# perf script --show-cgroup-events | grep PERF_RECORD_CGROUP -B2 -A2
           swapper     0     0.000000: PERF_RECORD_CGROUP cgroup: 1 /
              perf 12145 11200.440730:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
              perf 12145 11200.440733:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
  --
            cgtest 12145 11200.440739:     193472 cycles:  ffffffffb90f6fbc commit_creds+0x1fc (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12145 11200.440790:    2691608 cycles:      7fa2cb43019b _dl_sysdep_start+0x7cb (/usr/lib64/ld-2.29.so)
            cgtest 12145 11200.440962: PERF_RECORD_CGROUP cgroup: 83 /sub
            cgtest 12147 11200.441054:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12147 11200.441057:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
  --
            cgtest 12148 11200.441103:      10227 cycles:  ffffffffb9a0153d end_repeat_nmi+0x48 (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12148 11200.441106:     273295 cycles:  ffffffffb99ecbc7 copy_page+0x7 (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12147 11200.441133: PERF_RECORD_CGROUP cgroup: 88 /sub/cgrp1
            cgtest 12147 11200.441143:    2788845 cycles:  ffffffffb94676c2 security_genfs_sid+0x102 (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
            cgtest 12148 11200.441162: PERF_RECORD_CGROUP cgroup: 93 /sub/cgrp2
            cgtest 12148 11200.441182:    2669546 cycles:            401020 _init+0x20 (/wb/cgtest)
            cgtest 12149 11200.441247:          1 cycles:  ffffffffb900d58b __intel_pmu_enable_all.constprop.0+0x3b (/lib/modules/5.6.0-rc6-00008-gfe2413eefd7f/build/vmlinux)
  [root@seventh ~]#

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200325124536.2800725-10-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 ++-
 tools/perf/builtin-script.c              | 41 +++++++++++++++++++++++-
 2 files changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 4af255b..99a9853 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -319,6 +319,9 @@ OPTIONS
 --show-bpf-events
 	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.
 
+--show-cgroup-events
+	Display cgroup events i.e. events of type PERF_RECORD_CGROUP.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f63869a..186ebf8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1694,6 +1694,7 @@ struct perf_script {
 	bool			show_lost_events;
 	bool			show_round_events;
 	bool			show_bpf_events;
+	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct evswitch		evswitch;
@@ -2212,6 +2213,41 @@ out:
 	return ret;
 }
 
+static int process_cgroup_event(struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct thread *thread;
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	struct perf_session *session = script->session;
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	int ret = -1;
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (thread == NULL) {
+		pr_debug("problem processing CGROUP event, skipping it.\n");
+		return -1;
+	}
+
+	if (perf_event__process_cgroup(tool, event, sample, machine) < 0)
+		goto out;
+
+	if (!evsel->core.attr.sample_id_all) {
+		sample->cpu = 0;
+		sample->time = 0;
+	}
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_CGROUP, stdout);
+		perf_event__fprintf(event, stdout);
+	}
+	ret = 0;
+out:
+	thread__put(thread);
+	return ret;
+}
+
 static int process_fork_event(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -2551,6 +2587,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
+	if (script->show_cgroup_events)
+		script->tool.cgroup = process_cgroup_event;
 	if (script->show_lost_events)
 		script->tool.lost = process_lost_event;
 	if (script->show_round_events) {
@@ -3476,6 +3514,7 @@ int cmd_script(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.attr		 = process_attr,
@@ -3577,6 +3616,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-cgroup-events", &script.show_cgroup_events,
+		    "Show cgroup events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
 		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
