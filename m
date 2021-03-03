Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B432C784
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355627AbhCDAcJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842916AbhCCKW3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD6C061A28;
        Wed,  3 Mar 2021 00:45:34 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:45:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614761132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yb+bqoD+X245ondH2TPCv3xBe4JKVU//+6GIBcRKW1A=;
        b=pWXvAseRzGVX72p8yvQueg6xNSTTCtQ2S19X83jBdVBSk0Hs36epxVcGodetzCjncsSTmu
        ABiMwmXFSAGfMWYETmqJxpwN/9kxEVNqIISuw42hGACPvSR9VsNEtGOZgJshII+9GoH8gA
        14F/6PBaKVLy2qpnRnFcr9XVTSdjpIUgZqhf5Y/xr9IbKrkEBtZZd+x3ML9jTRCgcGG5Qj
        XAaOrrPvFtTjZxREqq4BNsRbHDKLAJRs03zKK+KYYwDKQCvWpRwbL6xGGuDMfD5AOQC5v6
        4CMgjZpuDZQ3MGkDFy/D1lBm6rp5VtV2EPDvh3dKGxixWNNy7mIwGpXJuRzHgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614761132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yb+bqoD+X245ondH2TPCv3xBe4JKVU//+6GIBcRKW1A=;
        b=AW8pyjDSRUj1jr5rk/JrFp3XBrMo1ANJV3D1IyGMJ9luFRmm5iMeuVahW0QhbEmTLZIb7U
        Id20i7fgm4wHWkBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Parse options from OBJTOOL_ARGS
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226110004.252553847@infradead.org>
References: <20210226110004.252553847@infradead.org>
MIME-Version: 1.0
Message-ID: <161476113169.20312.14290136035364654285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b52eb21aeca75790869c26b91b1d7b80b3946430
Gitweb:        https://git.kernel.org/tip/b52eb21aeca75790869c26b91b1d7b80b3946430
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Feb 2021 11:32:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 09:38:32 +01:00

objtool: Parse options from OBJTOOL_ARGS

Teach objtool to parse options from the OBJTOOL_ARGS environment
variable.

This enables things like:

  $ OBJTOOL_ARGS="--backup" make O=defconfig-build/ kernel/ponies.o

to obtain both defconfig-build/kernel/ponies.o{,.orig} and easily
inspect what objtool actually did.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20210226110004.252553847@infradead.org
---
 tools/objtool/builtin-check.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 0399752..8b38b5d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -15,6 +15,7 @@
 
 #include <subcmd/parse-options.h>
 #include <string.h>
+#include <stdlib.h>
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
@@ -26,6 +27,11 @@ static const char * const check_usage[] = {
 	NULL,
 };
 
+static const char * const env_usage[] = {
+	"OBJTOOL_ARGS=\"<options>\"",
+	NULL,
+};
+
 const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
@@ -44,6 +50,25 @@ const struct option check_options[] = {
 
 int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 {
+	const char *envv[16] = { };
+	char *env;
+	int envc;
+
+	env = getenv("OBJTOOL_ARGS");
+	if (env) {
+		envv[0] = "OBJTOOL_ARGS";
+		for (envc = 1; envc < ARRAY_SIZE(envv); ) {
+			envv[envc++] = env;
+			env = strchr(env, ' ');
+			if (!env)
+				break;
+			*env = '\0';
+			env++;
+		}
+
+		parse_options(envc, envv, check_options, env_usage, 0);
+	}
+
 	argc = parse_options(argc, argv, check_options, usage, 0);
 	if (argc != 1)
 		usage_with_options(usage, check_options);
