Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70DA32FA30
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCFLsy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhCFLsl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:41 -0500
Date:   Sat, 06 Mar 2021 11:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T8x8ztAnJo6bl1pmY4MS2LuKu9HiFs6RbEUMHKW/ow=;
        b=Tw689aN2SWNVKhjXm4YgKdRxPuOeJUocUku5WtiwMmmF8069Da7CDGke1PS64JRJMzFr0n
        t3R00tDuY/w/nSGloR07hkjDfJo6ztWhzqOnDR38NTGQHR9gMoTO/Odt20QKleNOkKsf2D
        xogJI/Ww43PW7/tisWOU8Y9BGtB4Fd6jjzqJYTD8WNW0daSeRhumS1lUq2uAiTWG90Bgns
        q7Ef+7LxXYBhB/zZNr3t1/FUAU4h4ogQbewmuig4aKlekcRHVwUqwoLlVNk6XGcFvZlxM8
        3bNhee5RWBdbxeldiE9xcWRdXw5grnS1jAiuXsA/10Ldr53JYenhBiz8HfF6Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7T8x8ztAnJo6bl1pmY4MS2LuKu9HiFs6RbEUMHKW/ow=;
        b=KX1McQ3S+PXRerSI2NkmuPBJrJI1YM0252Ps6OjAGC5w59dSandXHZAY0G/eUDD+EjZ7sR
        6Ocg7NM/q09q/6AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add --backup
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YD4obT3aoXPWl7Ax@hirez.programming.kicks-ass.net>
References: <YD4obT3aoXPWl7Ax@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161503131980.398.8868237092915126620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8ad15c6900840e8a2163012f4581c52127622e02
Gitweb:        https://git.kernel.org/tip/8ad15c6900840e8a2163012f4581c52127622e02
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Feb 2021 10:59:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:23 +01:00

objtool: Add --backup

Teach objtool to write backups files, such that it becomes easier to
see what objtool did to the object file.

Backup files will be ${name}.orig.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
