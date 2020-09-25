Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40607278722
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgIYMYG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgIYMX7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A82C0613D4;
        Fri, 25 Sep 2020 05:23:59 -0700 (PDT)
Date:   Fri, 25 Sep 2020 12:23:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emkQs3vKB7hw0BPiEKd92RTyPVBWsrF1ujI051y6DGU=;
        b=exRLJRXFI2ybmaMM3aJZ8XLVZinR+FHzo59hQZpDgQieTZklsi8u7gL30jQ7uOIQS0+K5c
        c1KlYVEl+d213OQLoemJWHP8z8x2wTIbkoWF74M64qklYnePUd5d0wjfXoyQqUAjcq62Ug
        HOHf2SlTMgzMv23TK8/cQ3GzN5WTtKCErI+kjHLn/LsuzJpVIyV7FzAnBNmQhASXYtdzzL
        FU11C+2u1JpwZPcNMkDKK3d3PNCcfG2HPd5MTeIrhP3UZc4Ziudser5GvUYn/oExgbNjWA
        EDLFTpwDe+SSoS3iyXB4rio8OaNUoekcwp6r4oTjGAYMAXTj81HZsCd8nCylgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emkQs3vKB7hw0BPiEKd92RTyPVBWsrF1ujI051y6DGU=;
        b=FTXMxGGL/AweSnv1ANHCUutHHEnG00NLG70DU3YD6bgMXlcmSuW34ggE5LvIJb2K+ah2g/
        1+/rTy4hQVYfhEDQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kprobes: Use module_name() macro
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
References: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160103663720.7002.11382280655100000628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e9ffc8c1b83931599663c21ba9082bcafa51d333
Gitweb:        https://git.kernel.org/tip/e9ffc8c1b83931599663c21ba9082bcafa51d333
Author:        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
AuthorDate:    Mon, 21 Sep 2020 21:24:25 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:49 +02:00

kprobes: Use module_name() macro

It is advised to use module_name() macro instead of dereferencing mod->name
directly. This makes sense for consistencys sake and also it prevents a
hard dependency to CONFIG_MODULES.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200818050857.117998-1-jarkko.sakkinen@linux.intel.com
---
 kernel/trace/trace_kprobe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb606..19c00ee 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -106,9 +106,10 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 						 struct module *mod)
 {
-	int len = strlen(mod->name);
+	int len = strlen(module_name(mod));
 	const char *name = trace_kprobe_symbol(tk);
-	return strncmp(mod->name, name, len) == 0 && name[len] == ':';
+
+	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
 }
 
 static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
@@ -688,7 +689,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
-					mod->name, ret);
+					module_name(mod), ret);
 		}
 	}
 	mutex_unlock(&event_mutex);
