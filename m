Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57BF7884B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Aug 2023 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbjHYKUi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Aug 2023 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244444AbjHYKUQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735BE213A;
        Fri, 25 Aug 2023 03:20:09 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Se/OG4hmJ3gzyETXfJM284Lal6U3di06YIBvnpDzC9E=;
        b=Oe+KD6JV7LImknRI9iAC37pE5oHfriDYh+njwCLCwqL6qoBVPjumAWXHh44m0hGh2DrUu3
        qvOaDs81YAQgHA8bxTgrYpWamMuKSDCLgqBun0i56+Nwh0+hvhqshMaI7sznKApsuYcjOo
        nNESzt1LUT1PRBFmxVpxklQry/KU4HgYDxHsaiOIZv3M+f+r/fQl6fFP2bw0biDnXamnlR
        aUIc5m5houlo/C9PHzA3II/WU7z8wpq477p9zuzIopZ5l3js+YCaTUWYCBKLhCSKwU0w5C
        nTpunS1CO8VYnileQRl4Qs7Fipf5Vs7odn9KmxW0H1qR742wwkba3J/Hb0jd2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Se/OG4hmJ3gzyETXfJM284Lal6U3di06YIBvnpDzC9E=;
        b=4Me3FimrBVuS2/SD68sAsFWgOC2feRau2rJSH2ky+AqgB5CXueXeiuOIfCUoCQa7D4V5PB
        pbiBsKISuCfjQgAQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Fix srso_show_state() side effect
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <40b2e6af3a94d2c6eb9a3afaa63f34ee910a17d0.1692919072.git.jpoimboe@kernel.org>
References: <40b2e6af3a94d2c6eb9a3afaa63f34ee910a17d0.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295877565.27769.402736621014345470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     c17312ac07853597500572e91a0469169f73058f
Gitweb:        https://git.kernel.org/tip/c17312ac07853597500572e91a0469169f73058f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:32 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:21:58 +02:00

x86/srso: Fix srso_show_state() side effect

Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
MSR write, and possibly even a (handled) exception if the microcode
hasn't been updated.

Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
gets set by srso_select_mitigation() if the updated microcode exists.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/40b2e6af3a94d2c6eb9a3afaa63f34ee910a17d0.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f081d26..bdd3e29 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2717,7 +2717,7 @@ static ssize_t srso_show_state(char *buf)
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
 static ssize_t gds_show_state(char *buf)
