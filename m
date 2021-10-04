Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDD42145F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 18:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbhJDQt2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbhJDQt0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 12:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E695C061753;
        Mon,  4 Oct 2021 09:47:36 -0700 (PDT)
Date:   Mon, 04 Oct 2021 16:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633366054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQfTX0+QWy8AR/LMf2oD0Tyys/5cpUdC7o1Q6E+409A=;
        b=MNFGqeCLFU7HPeyu6DEYuSNOaNpJf+KL1zHdcekiGzXSt6gnJhvAngv9bsbZ1D7oPlOOZM
        HF/QFK4kCUsII6U2GMfrVPZfLho3qZpXh9JJ2ImTlMhwrl3gh1KlUTMjLWkg26orWO0C2N
        l21YWt2TLwrLmCYMngH7u3axUcIelvRkHXHtWS03B7iTLEp9EFbxzGsoVJX7On+B0w8mfb
        KT/EejUNmEUemiuhel+8a7hIohhhNjjU8e1Y4iRfgWB7pi/JbY8xK2GAGpQqPQm8eoX1Qn
        owWKZzREaJvyvgkV4MccFdjAblgPtNMoVanngumecWmzYnvNRt1A5FOOLigQWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633366054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQfTX0+QWy8AR/LMf2oD0Tyys/5cpUdC7o1Q6E+409A=;
        b=lJroSFWuiw1nyGy/neId8MdUnw8fcrOqX0zCTcgzi2cF5L92TzbhXFePGDu5arQvaR8fui
        I89tNRPvoOkB3LCg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix kfree() of the wrong type in
 domain_add_cpu()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210917165924.28254-1-james.morse@arm.com>
References: <20210917165924.28254-1-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <163336605273.25758.522426152818829204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c51dd7e26b38b98e303f645ac18587d86eab2a73
Gitweb:        https://git.kernel.org/tip/c51dd7e26b38b98e303f645ac18587d86eab2a73
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 17 Sep 2021 16:59:24 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 18:36:14 +02:00

x86/resctrl: Fix kfree() of the wrong type in domain_add_cpu()

Commit in Fixes separated the architecture specific and filesystem parts
of the resctrl domain structures.

This left the error paths in domain_add_cpu() kfree()ing the memory with
the wrong type.

This will cause a problem if someone adds a new member to struct
rdt_hw_domain meaning d_resctrl is no longer the first member.

Fixes: 792e0f6f789b ("x86/resctrl: Split struct rdt_domain")
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20210917165924.28254-1-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b5de5a6..bb1c3f5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -527,14 +527,14 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	rdt_domain_reconfigure_cdp(r);
 
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
 	if (r->mon_capable && domain_setup_mon_state(r, d)) {
 		kfree(hw_dom->ctrl_val);
 		kfree(hw_dom->mbps_val);
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
