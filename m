Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83932C7AD
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388152AbhCDAcd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843003AbhCCKXg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026BC061A29;
        Wed,  3 Mar 2021 00:45:34 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:45:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614761133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlulZOOLEnSPNzDrEDwd1XW+S+DFJjEpojWC5AfxEHQ=;
        b=qSJ9mEwcYwlxR/bDEy7lwvEynJHvo7vbm5RVK0Hifs/oLmxDp7bChEsOoshXvGcgJU1EkY
        STs5qjc9To9DOdea1gh7bg3LAFVSsECuLQy1eIY927B7fQSB34wLtQkdgFrefeShdvLU0b
        2KVkHXJZMxBwV/moxNQvil/52iASPS2Y1oRX5PblFEBE3feK3W6Q/TOjLaUN1hhnvm0b8F
        FT5tnt2NZnshOMvn4KUKst7D77zVU0fyjWsK5s4Men772d3JPILOZEitoFp8/eYGbwEr/d
        Nq/bMmDvc6hOqhbjsT+4Im5h8Dkgc4ER+t+b3moDmLCU/T0fYbo5mtI6DnQb5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614761133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlulZOOLEnSPNzDrEDwd1XW+S+DFJjEpojWC5AfxEHQ=;
        b=GAe/cxLBwB2+jUOB0wKu18ZsAxp3bDYjCBWuP3ybH+U82n+zTzGIzGvU/50F6FfSkFc/Iu
        IvkXul+31pnXyZAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add --backup
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YD4obT3aoXPWl7Ax@hirez.programming.kicks-ass.net>
References: <YD4obT3aoXPWl7Ax@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161476113241.20312.274358186328661318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     327695eb9e3461b09d5cd5baef5df6526dd240c6
Gitweb:        https://git.kernel.org/tip/327695eb9e3461b09d5cd5baef5df6526dd240c6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Feb 2021 10:59:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 09:38:31 +01:00

objtool: Add --backup

Teach objtool to write backups files, such that it becomes easier to
see what objtool did to the object file.

Backup files will be ${name}.orig.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/YD4obT3aoXPWl7Ax@hirez.programming.kicks-ass.net
---
 tools/objtool/builtin-check.c           |  4 +-
 tools/objtool/include/objtool/builtin.h |  3 +-
 tools/objtool/objtool.c                 | 64 ++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c3a85d8..97f063d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -18,7 +18,8 @@
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount, noinstr;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
+     validate_dup, vmlinux, mcount, noinstr, backup;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -37,6 +38,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('n', "noinstr", &noinstr, "noinstr validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
+	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 2502bb2..d019210 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -8,7 +8,8 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount, noinstr;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
+            validate_dup, vmlinux, mcount, noinstr, backup;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 7b97ce4..43c1836 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -17,6 +17,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <subcmd/exec-cmd.h>
 #include <subcmd/pager.h>
 #include <linux/kernel.h>
@@ -44,6 +45,64 @@ bool help;
 const char *objname;
 static struct objtool_file file;
 
+static bool objtool_create_backup(const char *_objname)
+{
+	int len = strlen(_objname);
+	char *buf, *base, *name = malloc(len+6);
+	int s, d, l, t;
+
+	if (!name) {
+		perror("failed backup name malloc");
+		return false;
+	}
+
+	strcpy(name, _objname);
+	strcpy(name + len, ".orig");
+
+	d = open(name, O_CREAT|O_WRONLY|O_TRUNC, 0644);
+	if (d < 0) {
+		perror("failed to create backup file");
+		return false;
+	}
+
+	s = open(_objname, O_RDONLY);
+	if (s < 0) {
+		perror("failed to open orig file");
+		return false;
+	}
+
+	buf = malloc(4096);
+	if (!buf) {
+		perror("failed backup data malloc");
+		return false;
+	}
+
+	while ((l = read(s, buf, 4096)) > 0) {
+		base = buf;
+		do {
+			t = write(d, base, l);
+			if (t < 0) {
+				perror("failed backup write");
+				return false;
+			}
+			base += t;
+			l -= t;
+		} while (l);
+	}
+
+	if (l < 0) {
+		perror("failed backup read");
+		return false;
+	}
+
+	free(name);
+	free(buf);
+	close(d);
+	close(s);
+
+	return true;
+}
+
 struct objtool_file *objtool_open_read(const char *_objname)
 {
 	if (objname) {
@@ -59,6 +118,11 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	if (!file.elf)
 		return NULL;
 
+	if (backup && !objtool_create_backup(objname)) {
+		WARN("can't create backup file");
+		return NULL;
+	}
+
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	INIT_LIST_HEAD(&file.static_call_list);
