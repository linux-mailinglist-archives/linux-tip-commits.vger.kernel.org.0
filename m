Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488F61745BB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Feb 2020 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB2JRD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 29 Feb 2020 04:17:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38862 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgB2JRC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7yEq-0005oH-1s; Sat, 29 Feb 2020 10:16:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AEE1D1C2187;
        Sat, 29 Feb 2020 10:16:47 +0100 (CET)
Date:   Sat, 29 Feb 2020 09:16:47 -0000
From:   "tip-bot2 for He Zhe" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf probe: Check return value of strlist__add()
 for -ENOMEM
Cc:     He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1582727404-180095-1-git-send-email-zhe.he@windriver.com>
References: <1582727404-180095-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Message-ID: <158296780745.28353.11946839303577702274.tip-bot2@tip-bot2>
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

Commit-ID:     bd862b1d839221322b2e38eb8a06861604804b5e
Gitweb:        https://git.kernel.org/tip/bd862b1d839221322b2e38eb8a06861604804b5e
Author:        He Zhe <zhe.he@windriver.com>
AuthorDate:    Wed, 26 Feb 2020 22:30:04 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 27 Feb 2020 11:03:13 -03:00

perf probe: Check return value of strlist__add() for -ENOMEM

strlist__add() may fail with -ENOMEM. Check it and give debugging hint
in advance.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/1582727404-180095-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c   |  6 ++++--
 tools/perf/util/probe-file.c | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 26bc592..70548df 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -449,7 +449,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret = probe_file__del_strlist(kfd, klist);
 		if (ret < 0)
 			goto error;
-	}
+	} else if (ret == -ENOMEM)
+		goto error;
 
 	ret2 = probe_file__get_events(ufd, filter, ulist);
 	if (ret2 == 0) {
@@ -459,7 +460,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret2 = probe_file__del_strlist(ufd, ulist);
 		if (ret2 < 0)
 			goto error;
-	}
+	} else if (ret2 == -ENOMEM)
+		goto error;
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
 		pr_warning("\"%s\" does not hit any event.\n", str);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5003ba4..0f5fda1 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -301,10 +301,15 @@ int probe_file__get_events(int fd, struct strfilter *filter,
 		p = strchr(ent->s, ':');
 		if ((p && strfilter__compare(filter, p + 1)) ||
 		    strfilter__compare(filter, ent->s)) {
-			strlist__add(plist, ent->s);
+			ret = strlist__add(plist, ent->s);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 			ret = 0;
 		}
 	}
+out:
 	strlist__delete(namelist);
 
 	return ret;
@@ -511,7 +516,11 @@ static int probe_cache__load(struct probe_cache *pcache)
 				ret = -EINVAL;
 				goto out;
 			}
-			strlist__add(entry->tevlist, buf);
+			ret = strlist__add(entry->tevlist, buf);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 		}
 	}
 out:
@@ -672,7 +681,12 @@ int probe_cache__add_entry(struct probe_cache *pcache,
 		command = synthesize_probe_trace_command(&tevs[i]);
 		if (!command)
 			goto out_err;
-		strlist__add(entry->tevlist, command);
+		ret = strlist__add(entry->tevlist, command);
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			goto out_err;
+		}
+
 		free(command);
 	}
 	list_add_tail(&entry->node, &pcache->entries);
@@ -853,9 +867,15 @@ int probe_cache__scan_sdt(struct probe_cache *pcache, const char *pathname)
 			break;
 		}
 
-		strlist__add(entry->tevlist, buf);
+		ret = strlist__add(entry->tevlist, buf);
+
 		free(buf);
 		entry = NULL;
+
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			break;
+		}
 	}
 	if (entry) {
 		list_del_init(&entry->node);
