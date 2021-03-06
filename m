Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2704732FA3A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhCFLs5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCFLsr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B1C061760;
        Sat,  6 Mar 2021 03:48:47 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7XsPDXIAlGV/PIFreHDZ+nJ2sDnp5r+3/3683Zy0uE=;
        b=26RU+fn8WlGLS16VBtlOXTlciZdHts8zh6OjcPeOobmtf3iqyomt/DtOIN8Jb2LxLMpDq0
        lUbNalIpRqmwkZaQ8voek/k54P9HJba47uZ+Trg0iaMSPceSyFCid/jjWMEpknTFJLVZTZ
        SR8SHAKj/iSi1v2btOKAud64nyfHVHWim8jDc6+h6gRwKV40p7dXl9moAMdZkGUvPheyGU
        5i4iXeJDBcU23WcewBFNqamAlIkDjFvqpPFEXG9zCp4m2fcrHWnbq9VIv+cI+Qyj9dgaNQ
        ETOkgBfO8mPpJWfaOf0JSWA9HLrXHNbcLC+vHl0Cf0tJTSXJA3O/DB5X2XMZAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7XsPDXIAlGV/PIFreHDZ+nJ2sDnp5r+3/3683Zy0uE=;
        b=HF6kCc5SNKyv7aUSapnItt4YxQySPKJVXGEFp5v5xrqKFly6EzG5tfm1/znxNebNwcVEaf
        ZtVme6wFa9uzvEAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Parse options from OBJTOOL_ARGS
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226110004.252553847@infradead.org>
References: <20210226110004.252553847@infradead.org>
MIME-Version: 1.0
Message-ID: <161503131911.398.14570626719309626291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     900b4df347bbac4874149a226143a556909faba8
Gitweb:        https://git.kernel.org/tip/900b4df347bbac4874149a226143a556909faba8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Feb 2021 11:32:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:23 +01:00

objtool: Parse options from OBJTOOL_ARGS

Teach objtool to parse options from the OBJTOOL_ARGS environment
variable.

This enables things like:

  $ OBJTOOL_ARGS="--backup" make O=defconfig-build/ kernel/ponies.o

to obtain both defconfig-build/kernel/ponies.o{,.orig} and easily
inspect what objtool actually did.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
