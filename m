Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4A2FEB74
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Jan 2021 14:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbhAUNTS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Jan 2021 08:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbhAUNTR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Jan 2021 08:19:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9CEC061575;
        Thu, 21 Jan 2021 05:18:35 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:18:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611235112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lURqevUYUDpCu9mL3rIAadIbs3F8mPP2Rdm5EoaVJbA=;
        b=cYeNi7sU00DhPOx5N3iSay99c9vACMqmAjXRLtwdCnHcNVqnRCbibA7YzKkDBNaiPXbGAB
        f7ZHZ0qKr2Ut6wp3eguFUf8NDUZUu3tkRIy3FoePbi5c3bxR6ZsBHaHPrC25eM5HM3gUQQ
        YB6zOqMv6MQ4TXqZAomZiIUWg5sDwdg8KYrasf1ZwvjywbHsK4GnrG7/v+nW/P4lafvGLQ
        EZ/fae7cYsIuRScj/yFld4jNbljjsiODPIrYVJ9WK+Xz1gJlZ75/xNBpViRVnENzyFLI3y
        3TI0g86R8dqO3uxDmQNARZFRGhX5M4/a8saJfu3tZsuM4U0IDJ/VB3fFOb+Qzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611235112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lURqevUYUDpCu9mL3rIAadIbs3F8mPP2Rdm5EoaVJbA=;
        b=+cyow1On1NQTY/IyN1E6mBOB2mXgb5WF22OkMMWxYGqWb1ixlAaKS1t1KczNaSWcV9E1h9
        TjPAkBRk3lDltyCQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] MAINTAINERS: Fix the tree location for INTEL SGX patches
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121024256.54565-1-jarkko@kernel.org>
References: <20210121024256.54565-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <161123511167.414.16248685766014253391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     3ac517313b929619dbb7ceae005ec66d0859b23b
Gitweb:        https://git.kernel.org/tip/3ac517313b929619dbb7ceae005ec66d0859b23b
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Thu, 21 Jan 2021 04:42:56 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Jan 2021 14:13:20 +01:00

MAINTAINERS: Fix the tree location for INTEL SGX patches

After a discussion with Boris et al, I've come to realize that a
disjoint GIT tree for SGX does not make any sense.

Instead, follow the pattern of other MAINTAINERS entries, IRQ DOMAINS for
instance, and re-define T-entry so that it will reference the pre-existing
topic branch for SGX. As Boris explained to me, reviewed patches will be
routinely picked to this branch.

Fixes: bc4bac2ecef0 ("x86/sgx: Update MAINTAINERS")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210121024256.54565-1-jarkko@kernel.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1e6a5..5b66de2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9230,7 +9230,7 @@ M:	Jarkko Sakkinen <jarkko@kernel.org>
 L:	linux-sgx@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/intel-sgx/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
 F:	Documentation/x86/sgx.rst
 F:	arch/x86/entry/vdso/vsgx.S
 F:	arch/x86/include/uapi/asm/sgx.h
