Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7304232FA3B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhCFLs6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCFLsr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC5C06174A;
        Sat,  6 Mar 2021 03:48:47 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEAyueJVVGy9v6xizSUwnZHFoMMWuDJhvwDU7eP8w0A=;
        b=IzjAJdH/mbQ7uzCAEWLc3vAvy7dBf2VGZpK/a/FARmamqZDg8K8f3KiDsn5+fMZceTGejb
        UfIn/uSx5P3p8td5u5ZUYjdeBZKYerTlebPEvEX6DoYoqr0nnczJjM4RqcstRoMbc8a+hI
        bNXEGn1We3JxR8rwqiqS59vsY3cgoxWIpFViVnOLMNELyLya0yxi7RVVVicGmqqm82RJ0X
        KzseML1egzv8Z+1Zt/ZkoFGCbkiHOxIrqouSARnMHoSH+8RlXxyUpmSF0J8YARNzqfhGcF
        dURxs+FrxjDl6mRhYdOflzJG5ZtBJOQuni0WDBrewW/1PhmtY/5dio7CgvmsrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEAyueJVVGy9v6xizSUwnZHFoMMWuDJhvwDU7eP8w0A=;
        b=2K2ZfS1qooMY1osnqxPTzpab/nxatx8egZ4l3HXgdXyVMakG68Rq14h9O8u2Ict5gMeTD3
        PKikJjxYybULlVAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Collate parse_options() users
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226110004.193108106@infradead.org>
References: <20210226110004.193108106@infradead.org>
MIME-Version: 1.0
Message-ID: <161503131954.398.4348232937211103861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a2f605f9ff57397d05a8e2f282b78a69f574d305
Gitweb:        https://git.kernel.org/tip/a2f605f9ff57397d05a8e2f282b78a69f574d305
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Feb 2021 11:18:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:23 +01:00

objtool: Collate parse_options() users

Ensure there's a single place that parses check_options, in
preparation for extending where to get options from.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20210226110004.193108106@infradead.org
---
 tools/objtool/builtin-check.c           | 14 +++++++++-----
 tools/objtool/builtin-orc.c             |  5 +----
 tools/objtool/include/objtool/builtin.h |  2 ++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 97f063d..0399752 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -42,17 +42,21 @@ const struct option check_options[] = {
 	OPT_END(),
 };
 
+int cmd_parse_options(int argc, const char **argv, const char * const usage[])
+{
+	argc = parse_options(argc, argv, check_options, usage, 0);
+	if (argc != 1)
+		usage_with_options(usage, check_options);
+	return argc;
+}
+
 int cmd_check(int argc, const char **argv)
 {
 	const char *objname;
 	struct objtool_file *file;
 	int ret;
 
-	argc = parse_options(argc, argv, check_options, check_usage, 0);
-
-	if (argc != 1)
-		usage_with_options(check_usage, check_options);
-
+	argc = cmd_parse_options(argc, argv, check_usage);
 	objname = argv[0];
 
 	file = objtool_open_read(objname);
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
index 8273bbf..17f8b93 100644
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -34,10 +34,7 @@ int cmd_orc(int argc, const char **argv)
 		struct objtool_file *file;
 		int ret;
 
-		argc = parse_options(argc, argv, check_options, orc_usage, 0);
-		if (argc != 1)
-			usage_with_options(orc_usage, check_options);
-
+		argc = cmd_parse_options(argc, argv, orc_usage);
 		objname = argv[0];
 
 		file = objtool_open_read(objname);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index d019210..15ac0b7 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -11,6 +11,8 @@ extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
             validate_dup, vmlinux, mcount, noinstr, backup;
 
+extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
+
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
 
