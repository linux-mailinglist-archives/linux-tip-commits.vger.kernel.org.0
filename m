Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69578D6EF8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2019 07:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfJOFcJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Oct 2019 01:32:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42080 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfJOFcJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQl-0008Rw-G4; Tue, 15 Oct 2019 07:31:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B954D1C0105;
        Tue, 15 Oct 2019 07:31:34 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:34 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf diff: Report noisy for cycles diff
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190925011446.30678-1-yao.jin@linux.intel.com>
References: <20190925011446.30678-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157111749459.12254.14694018417962510084.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cebf7d51a6c3babc4d0589da7aec0de1af0a5691
Gitweb:        https://git.kernel.org/tip/cebf7d51a6c3babc4d0589da7aec0de1af0a5691
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Wed, 25 Sep 2019 09:14:46 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 11 Oct 2019 10:57:00 -03:00

perf diff: Report noisy for cycles diff

This patch prints the stddev and hist for the cycles diff of program
block. It can help us to understand if the cycles is noisy or not.

This patch is inspired by Andi Kleen's patch:

  https://lwn.net/Articles/600471/

We create new option '--cycles-hist'.

Example:

  perf record -b ./div
  perf record -b ./div
  perf diff -c cycles

  # Baseline                                [Program Block Range] Cycles Diff  Shared Object      Symbol
  # ........  .......................................................... ....  .................  ............................
  #
      46.72%                                      [div.c:40 -> div.c:40]    0  div                [.] main
      46.72%                                      [div.c:42 -> div.c:44]    0  div                [.] main
      46.72%                                      [div.c:42 -> div.c:39]    0  div                [.] main
      20.54%                          [random_r.c:357 -> random_r.c:394]    1  libc-2.27.so       [.] __random_r
      20.54%                          [random_r.c:357 -> random_r.c:380]    0  libc-2.27.so       [.] __random_r
      20.54%                          [random_r.c:388 -> random_r.c:388]    0  libc-2.27.so       [.] __random_r
      20.54%                          [random_r.c:388 -> random_r.c:391]    0  libc-2.27.so       [.] __random_r
      17.04%                              [random.c:288 -> random.c:291]    0  libc-2.27.so       [.] __random
      17.04%                              [random.c:291 -> random.c:291]    0  libc-2.27.so       [.] __random
      17.04%                              [random.c:293 -> random.c:293]    0  libc-2.27.so       [.] __random
      17.04%                              [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
      17.04%                              [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
      17.04%                              [random.c:298 -> random.c:298]    0  libc-2.27.so       [.] __random
       8.40%                                      [div.c:22 -> div.c:25]    0  div                [.] compute_flag
       8.40%                                      [div.c:27 -> div.c:28]    0  div                [.] compute_flag
       5.14%                                    [rand.c:26 -> rand.c:27]    0  libc-2.27.so       [.] rand
       5.14%                                    [rand.c:28 -> rand.c:28]    0  libc-2.27.so       [.] rand
       2.15%                                  [rand@plt+0 -> rand@plt+0]    0  div                [.] rand@plt
       0.00%                                                                   [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
       0.00%                                [do_mmap+714 -> do_mmap+732]  -10  [kernel.kallsyms]  [k] do_mmap
       0.00%                                [do_mmap+737 -> do_mmap+765]    1  [kernel.kallsyms]  [k] do_mmap
       0.00%                                [do_mmap+262 -> do_mmap+299]    0  [kernel.kallsyms]  [k] do_mmap
       0.00%  [__x86_indirect_thunk_r15+0 -> __x86_indirect_thunk_r15+0]    7  [kernel.kallsyms]  [k] __x86_indirect_thunk_r15
       0.00%            [native_sched_clock+0 -> native_sched_clock+119]   -1  [kernel.kallsyms]  [k] native_sched_clock
       0.00%                 [native_write_msr+0 -> native_write_msr+16]  -13  [kernel.kallsyms]  [k] native_write_msr

When we enable the option '--cycles-hist', the output is

  perf diff -c cycles --cycles-hist

  # Baseline                                [Program Block Range] Cycles Diff        stddev/Hist  Shared Object      Symbol
  # ........  .......................................................... ....  .................  .................  ............................
  #
      46.72%                                      [div.c:40 -> div.c:40]    0  ± 37.8% ▁█▁▁██▁█   div                [.] main
      46.72%                                      [div.c:42 -> div.c:44]    0  ± 49.4% ▁▁▂█▂▂▂▂   div                [.] main
      46.72%                                      [div.c:42 -> div.c:39]    0  ± 24.1% ▃█▂▄▁▃▂▁   div                [.] main
      20.54%                          [random_r.c:357 -> random_r.c:394]    1  ± 33.5% ▅▂▁█▃▁▂▁   libc-2.27.so       [.] __random_r
      20.54%                          [random_r.c:357 -> random_r.c:380]    0  ± 39.4% ▁▁█▁██▅▁   libc-2.27.so       [.] __random_r
      20.54%                          [random_r.c:388 -> random_r.c:388]    0                     libc-2.27.so       [.] __random_r
      20.54%                          [random_r.c:388 -> random_r.c:391]    0  ± 41.2% ▁▃▁▂█▄▃▁   libc-2.27.so       [.] __random_r
      17.04%                              [random.c:288 -> random.c:291]    0  ± 48.8% ▁▁▁▁███▁   libc-2.27.so       [.] __random
      17.04%                              [random.c:291 -> random.c:291]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
      17.04%                              [random.c:293 -> random.c:293]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
      17.04%                              [random.c:295 -> random.c:295]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
      17.04%                              [random.c:295 -> random.c:295]    0                     libc-2.27.so       [.] __random
      17.04%                              [random.c:298 -> random.c:298]    0  ± 75.6% ▃█▁▁▁▁▁▁   libc-2.27.so       [.] __random
       8.40%                                      [div.c:22 -> div.c:25]    0  ± 42.1% ▁▃▁▁███▁   div                [.] compute_flag
       8.40%                                      [div.c:27 -> div.c:28]    0  ± 41.8% ██▁▁▄▁▁▄   div                [.] compute_flag
       5.14%                                    [rand.c:26 -> rand.c:27]    0  ± 37.8% ▁▁▁████▁   libc-2.27.so       [.] rand
       5.14%                                    [rand.c:28 -> rand.c:28]    0                     libc-2.27.so       [.] rand
       2.15%                                  [rand@plt+0 -> rand@plt+0]    0                     div                [.] rand@plt
       0.00%                                                                                      [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
       0.00%                                [do_mmap+714 -> do_mmap+732]  -10                     [kernel.kallsyms]  [k] do_mmap
       0.00%                                [do_mmap+737 -> do_mmap+765]    1                     [kernel.kallsyms]  [k] do_mmap
       0.00%                                [do_mmap+262 -> do_mmap+299]    0                     [kernel.kallsyms]  [k] do_mmap
       0.00%  [__x86_indirect_thunk_r15+0 -> __x86_indirect_thunk_r15+0]    7                     [kernel.kallsyms]  [k] __x86_indirect_thunk_r15
       0.00%            [native_sched_clock+0 -> native_sched_clock+119]   -1  ± 38.5% ▄█▁        [kernel.kallsyms]  [k] native_sched_clock
       0.00%                 [native_write_msr+0 -> native_write_msr+16]  -13  ± 47.1% ▁█▇▃▁▁     [kernel.kallsyms]  [k] native_write_msr

 v8:
 ---
 Rebase to perf/core branch

 v7:
 ---
 1. v6 got Jiri's ACK.
 2. Rebase to latest perf/core branch.

 v6:
 ---
 1. Jiri provides better code for using data__hpp_register() in ui_init().
    Use this code in v6.

 v5:
 ---
 1. Refine the use of data__hpp_register() in ui_init() according to
    Jiri's suggestion.

 v4:
 ---
 1. Rename the new option from '--noisy' to '--cycles-hist'
 2. Remove the option '-n'.
 3. Only update the spark value and stats when '--cycles-hist' is enabled.
 4. Remove the code of printing '..'.

 v3:
 ---
 1. Move the histogram to a separate column
 2. Move the svals[] out of struct stats

 v2:
 ---
 Jiri got a compile error,

  CC       builtin-diff.o
  builtin-diff.c: In function ‘compute_cycles_diff’:
  builtin-diff.c:712:10: error: taking the absolute value of unsigned type ‘u64’ {aka ‘long unsigned int’} has no effect [-Werror=absolute-value]
  712 |          labs(pair->block_info->cycles_spark[i] -
      |          ^~~~

 Because the result of u64 - u64 is still u64. Now we change the type of
 cycles_spark[] to s64.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190925011446.30678-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt |   5 +-
 tools/perf/builtin-diff.c              | 143 ++++++++++++++++++++++++-
 tools/perf/util/Build                  |   1 +-
 tools/perf/util/annotate.c             |   4 +-
 tools/perf/util/annotate.h             |   2 +-
 tools/perf/util/sort.h                 |   4 +-
 tools/perf/util/spark.c                |  34 ++++++-
 tools/perf/util/spark.h                |   8 +-
 tools/perf/util/symbol.h               |   2 +-
 9 files changed, 203 insertions(+)
 create mode 100644 tools/perf/util/spark.c
 create mode 100644 tools/perf/util/spark.h

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index d5cc15e..f50ca0f 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -95,6 +95,11 @@ OPTIONS
         diff.compute config option.  See COMPARISON METHODS section for
         more info.
 
+--cycles-hist::
+	Report a histogram and the standard deviation for cycles data.
+	It can help us to judge if the reported cycles data is noisy or
+	not. This option should be used with '-c cycles'.
+
 -p::
 --period::
         Show period values for both compared hist entries.
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c37a786..5281629 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -23,6 +23,7 @@
 #include "util/time-utils.h"
 #include "util/annotate.h"
 #include "util/map.h"
+#include "util/spark.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -53,6 +54,7 @@ enum {
 	PERF_HPP_DIFF__FORMULA,
 	PERF_HPP_DIFF__DELTA_ABS,
 	PERF_HPP_DIFF__CYCLES,
+	PERF_HPP_DIFF__CYCLES_HIST,
 
 	PERF_HPP_DIFF__MAX_INDEX
 };
@@ -87,6 +89,7 @@ static bool force;
 static bool show_period;
 static bool show_formula;
 static bool show_baseline_only;
+static bool cycles_hist;
 static unsigned int sort_compute = 1;
 
 static s64 compute_wdiff_w1;
@@ -164,6 +167,10 @@ static struct header_column {
 	[PERF_HPP_DIFF__CYCLES] = {
 		.name  = "[Program Block Range] Cycles Diff",
 		.width = 70,
+	},
+	[PERF_HPP_DIFF__CYCLES_HIST] = {
+		.name  = "stddev/Hist",
+		.width = NUM_SPARKS + 9,
 	}
 };
 
@@ -610,6 +617,9 @@ static void init_block_info(struct block_info *bi, struct symbol *sym,
 	bi->cycles_aggr = ch->cycles_aggr;
 	bi->num = ch->num;
 	bi->num_aggr = ch->num_aggr;
+
+	memcpy(bi->cycles_spark, ch->cycles_spark,
+	       NUM_SPARKS * sizeof(u64));
 }
 
 static int process_block_per_sym(struct hist_entry *he)
@@ -689,6 +699,21 @@ static struct hist_entry *get_block_pair(struct hist_entry *he,
 	return NULL;
 }
 
+static void init_spark_values(unsigned long *svals, int num)
+{
+	for (int i = 0; i < num; i++)
+		svals[i] = 0;
+}
+
+static void update_spark_value(unsigned long *svals, int num,
+			       struct stats *stats, u64 val)
+{
+	int n = stats->n;
+
+	if (n < num)
+		svals[n] = val;
+}
+
 static void compute_cycles_diff(struct hist_entry *he,
 				struct hist_entry *pair)
 {
@@ -697,6 +722,26 @@ static void compute_cycles_diff(struct hist_entry *he,
 		pair->diff.cycles =
 			pair->block_info->cycles_aggr / pair->block_info->num_aggr -
 			he->block_info->cycles_aggr / he->block_info->num_aggr;
+
+		if (!cycles_hist)
+			return;
+
+		init_stats(&pair->diff.stats);
+		init_spark_values(pair->diff.svals, NUM_SPARKS);
+
+		for (int i = 0; i < pair->block_info->num; i++) {
+			u64 val;
+
+			if (i >= he->block_info->num || i >= NUM_SPARKS)
+				break;
+
+			val = labs(pair->block_info->cycles_spark[i] -
+				     he->block_info->cycles_spark[i]);
+
+			update_spark_value(pair->diff.svals, NUM_SPARKS,
+					   &pair->diff.stats, val);
+			update_stats(&pair->diff.stats, val);
+		}
 	}
 }
 
@@ -1255,6 +1300,9 @@ static const struct option options[] = {
 		    "Show period values."),
 	OPT_BOOLEAN('F', "formula", &show_formula,
 		    "Show formula."),
+	OPT_BOOLEAN(0, "cycles-hist", &cycles_hist,
+		    "Show cycles histogram and standard deviation "
+		    "- WARNING: use only with -c cycles."),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
@@ -1462,6 +1510,90 @@ static int hpp__color_cycles(struct perf_hpp_fmt *fmt,
 	return __hpp__color_compare(fmt, hpp, he, COMPUTE_CYCLES);
 }
 
+static int all_zero(unsigned long *vals, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (vals[i] != 0)
+			return 0;
+	return 1;
+}
+
+static int print_cycles_spark(char *bf, int size, unsigned long *svals, u64 n)
+{
+	int printed;
+
+	if (n <= 1)
+		return 0;
+
+	if (n > NUM_SPARKS)
+		n = NUM_SPARKS;
+	if (all_zero(svals, n))
+		return 0;
+
+	printed = print_spark(bf, size, svals, n);
+	printed += scnprintf(bf + printed, size - printed, " ");
+	return printed;
+}
+
+static int hpp__color_cycles_hist(struct perf_hpp_fmt *fmt,
+			    struct perf_hpp *hpp, struct hist_entry *he)
+{
+	struct diff_hpp_fmt *dfmt =
+		container_of(fmt, struct diff_hpp_fmt, fmt);
+	struct hist_entry *pair = get_pair_fmt(he, dfmt);
+	struct block_hist *bh = container_of(he, struct block_hist, he);
+	struct block_hist *bh_pair;
+	struct hist_entry *block_he;
+	char spark[32], buf[128];
+	double r;
+	int ret, pad;
+
+	if (!pair) {
+		if (bh->block_idx)
+			hpp->skip = true;
+
+		goto no_print;
+	}
+
+	bh_pair = container_of(pair, struct block_hist, he);
+
+	block_he = hists__get_entry(&bh_pair->block_hists, bh->block_idx);
+	if (!block_he) {
+		hpp->skip = true;
+		goto no_print;
+	}
+
+	ret = print_cycles_spark(spark, sizeof(spark), block_he->diff.svals,
+				 block_he->diff.stats.n);
+
+	r = rel_stddev_stats(stddev_stats(&block_he->diff.stats),
+			     avg_stats(&block_he->diff.stats));
+
+	if (ret) {
+		/*
+		 * Padding spaces if number of sparks less than NUM_SPARKS
+		 * otherwise the output is not aligned.
+		 */
+		pad = NUM_SPARKS - ((ret - 1) / 3);
+		scnprintf(buf, sizeof(buf), "%s%5.1f%% %s", "\u00B1", r, spark);
+		ret = scnprintf(hpp->buf, hpp->size, "%*s",
+				dfmt->header_width, buf);
+
+		if (pad) {
+			ret += scnprintf(hpp->buf + ret, hpp->size - ret,
+					 "%-*s", pad, " ");
+		}
+
+		return ret;
+	}
+
+no_print:
+	return scnprintf(hpp->buf, hpp->size, "%*s",
+			dfmt->header_width, " ");
+}
+
 static void
 hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
 {
@@ -1667,6 +1799,10 @@ static void data__hpp_register(struct data__file *d, int idx)
 		fmt->color = hpp__color_cycles;
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
+	case PERF_HPP_DIFF__CYCLES_HIST:
+		fmt->color = hpp__color_cycles_hist;
+		fmt->sort  = hist_entry__cmp_nop;
+		break;
 	default:
 		fmt->sort  = hist_entry__cmp_nop;
 		break;
@@ -1692,10 +1828,14 @@ static int ui_init(void)
 		 *   PERF_HPP_DIFF__DELTA
 		 *   PERF_HPP_DIFF__RATIO
 		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
+		 *   PERF_HPP_DIFF__CYCLES
 		 */
 		data__hpp_register(d, i ? compute_2_hpp[compute] :
 					  PERF_HPP_DIFF__BASELINE);
 
+		if (cycles_hist && i)
+			data__hpp_register(d, PERF_HPP_DIFF__CYCLES_HIST);
+
 		/*
 		 * And the rest:
 		 *
@@ -1850,6 +1990,9 @@ int cmd_diff(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	if (cycles_hist && (compute != COMPUTE_CYCLES))
+		usage_with_options(diff_usage, options);
+
 	symbol__annotation_init();
 
 	if (symbol__init(NULL) < 0)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8dcfca1..39814b1 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -95,6 +95,7 @@ perf-y += cloexec.o
 perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
+perf-y += spark.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4036c7f..2b856b6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -853,6 +853,10 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 			   ch[offset].start < start)
 			return 0;
 	}
+
+	if (ch[offset].num < NUM_SPARKS)
+		ch[offset].cycles_spark[ch[offset].num] = cycles;
+
 	ch[offset].have_start = have_start;
 	ch[offset].start = start;
 	ch[offset].cycles += cycles;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d76fd0e..3528bd4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -11,6 +11,7 @@
 #include <pthread.h>
 #include <asm/bug.h>
 #include "symbol_conf.h"
+#include "spark.h"
 
 struct hist_browser_timer;
 struct hist_entry;
@@ -235,6 +236,7 @@ struct cyc_hist {
 	u64	cycles_aggr;
 	u64	cycles_max;
 	u64	cycles_min;
+	s64	cycles_spark[NUM_SPARKS];
 	u32	num;
 	u32	num_aggr;
 	u8	have_start;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 7b93f34..5aff954 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -10,6 +10,8 @@
 #include "callchain.h"
 #include "values.h"
 #include "hist.h"
+#include "stat.h"
+#include "spark.h"
 
 struct option;
 struct thread;
@@ -71,6 +73,8 @@ struct hist_entry_diff {
 		/* PERF_HPP_DIFF__CYCLES */
 		s64	cycles;
 	};
+	struct stats	stats;
+	unsigned long	svals[NUM_SPARKS];
 };
 
 struct hist_entry_ops {
diff --git a/tools/perf/util/spark.c b/tools/perf/util/spark.c
new file mode 100644
index 0000000..70272a8
--- /dev/null
+++ b/tools/perf/util/spark.c
@@ -0,0 +1,34 @@
+#include <stdio.h>
+#include <limits.h>
+#include <string.h>
+#include <stdlib.h>
+#include "spark.h"
+#include "stat.h"
+
+#define SPARK_SHIFT 8
+
+/* Print spark lines on outf for numval values in val. */
+int print_spark(char *bf, int size, unsigned long *val, int numval)
+{
+	static const char *ticks[NUM_SPARKS] = {
+		"▁",  "▂", "▃", "▄", "▅", "▆", "▇", "█"
+	};
+	int i, printed = 0;
+	unsigned long min = ULONG_MAX, max = 0, f;
+
+	for (i = 0; i < numval; i++) {
+		if (val[i] < min)
+			min = val[i];
+		if (val[i] > max)
+			max = val[i];
+	}
+	f = ((max - min) << SPARK_SHIFT) / (NUM_SPARKS - 1);
+	if (f < 1)
+		f = 1;
+	for (i = 0; i < numval; i++) {
+		printed += scnprintf(bf + printed, size - printed, "%s",
+				     ticks[((val[i] - min) << SPARK_SHIFT) / f]);
+	}
+
+	return printed;
+}
diff --git a/tools/perf/util/spark.h b/tools/perf/util/spark.h
new file mode 100644
index 0000000..25402d7
--- /dev/null
+++ b/tools/perf/util/spark.h
@@ -0,0 +1,8 @@
+#ifndef SPARK_H
+#define SPARK_H 1
+
+#define NUM_SPARKS 8
+
+int print_spark(char *bf, int size, unsigned long *val, int numval);
+
+#endif
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0b0c6b5..cc2a89b 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include "path.h"
 #include "symbol_conf.h"
+#include "spark.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 #include <libelf.h>
@@ -111,6 +112,7 @@ struct block_info {
 	u64			end;
 	u64			cycles;
 	u64			cycles_aggr;
+	s64			cycles_spark[NUM_SPARKS];
 	int			num;
 	int			num_aggr;
 	refcount_t		refcnt;
