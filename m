Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D453422399
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhJEKe2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 06:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhJEKe2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 06:34:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B4AC06161C;
        Tue,  5 Oct 2021 03:32:37 -0700 (PDT)
Date:   Tue, 05 Oct 2021 10:32:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633429956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJsXPZvCT1QH2N6CtrKUIp+7vL0DCRxtWZike5cM/Ms=;
        b=0CvdxiRUrFVmLMMqGDPWuCbYX8g32XIrEsl0yz+qDSHh5EqnTzWHcWuTntZGupzfdg66s8
        7sx8c7CeJYK5iBPncHq7807v5hSWS69OMjt9oa0G+2J3s6F4II3eCium8gMgr7/g4NHw6w
        1NG1balxTkbsy53Yy9C/bXIKl8aLag+gKrV77Yx5XLoS+/QsBZKJ4j7Y24vlBFkDPSRZ0w
        7HhJjstKnNTZ0ZbM6j84B4go6Kmyk8HCjqNAaWhgLK4LY/K0xl6Gj7dEkH2hD7DpfgEaaV
        jZheVFaK/vMbHbiBJbLr9XaVTQ11rheT5EaYVtnS49sQXK4NIVU1caySi1ZWng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633429956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJsXPZvCT1QH2N6CtrKUIp+7vL0DCRxtWZike5cM/Ms=;
        b=g9mlaeH2TEQWHYjAiM7BZp3YnWRVfTNqdtUiEYs6+sFa1q4jeJw66PxEmMeJ+JW0SbQlEa
        9R/iC+3MdatQcVAA==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Correct reference to intended CONFIG_64_BIT
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803113531.30720-2-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-2-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <163342995542.25758.18109528027795851140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b2c238397b8f737590a7f1b4e8f9dbbd5043e340
Gitweb:        https://git.kernel.org/tip/b2c238397b8f737590a7f1b4e8f9dbbd5043e340
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Tue, 03 Aug 2021 13:35:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Oct 2021 11:10:21 +02:00

x86/entry: Correct reference to intended CONFIG_64_BIT

Commit in Fixes adds a condition with IS_ENABLED(CONFIG_64_BIT),
but the intended config item is called CONFIG_64BIT, as defined in
arch/x86/Kconfig.

Fortunately, scripts/checkkconfigsymbols.py warns:

64_BIT
Referencing files: arch/x86/include/asm/entry-common.h

Correct the reference to the intended config symbol.

Fixes: 662a0221893a ("x86/entry: Fix AC assertion")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210803113531.30720-2-lukas.bulwahn@gmail.com
---
 arch/x86/include/asm/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 14ebd21..4318464 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -25,7 +25,7 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 		 * For !SMAP hardware we patch out CLAC on entry.
 		 */
 		if (boot_cpu_has(X86_FEATURE_SMAP) ||
-		    (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
+		    (IS_ENABLED(CONFIG_64BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
 			mask |= X86_EFLAGS_AC;
 
 		WARN_ON_ONCE(flags & mask);
