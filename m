Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94E3A7C71
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFOKyF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 06:54:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhFOKyD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 06:54:03 -0400
Date:   Tue, 15 Jun 2021 10:51:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623754318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAD78roLTwHJYa2yvPvMrLxKDgh4hQEfB2VKFH9f4io=;
        b=3uKOqygZU+/8aciF/Ct9OedckyE1DNkaMmeIvrXtz2epsJt3FrsbXOzTDV/XKFDaYeH7wI
        fq2Z7eXi3+cgB9ltaW/0Pw9g/6t24wf0mdx92XM86+v8NTeL6VlVfJYsU5Ebu7P0eOzy/m
        N/gxHHeR8HHcx2OfvMSGO7TXmE2yxi2Yz7bCsFpigjU0G+i9tf9xkQxJ5WCxZ7BLnZFrcS
        SaAVDkaer88L/03HQIQsf2pq0T3ETNRvuYsjiM4CZOV/v7LpJzTNA1UKBvoXY1KseK+YjL
        hun7AFHamQmK3ouorp4oVOl054cFtL8tvP/H7+bwoZuNCh4FX+SzTyf31HsiNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623754318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAD78roLTwHJYa2yvPvMrLxKDgh4hQEfB2VKFH9f4io=;
        b=WfIg6306/IBq1MrWBUCD4UXrKdzAiLGRwe0ord+BBex8LZahphIF6ocesnYyNZhaHF7G/1
        4fWbWK+Dxzfv0PDA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Fix error message in runtime #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210614135327.9921-2-joro@8bytes.org>
References: <20210614135327.9921-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <162375431755.19906.1990117369967751393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     4aca2d99fd27698cf82d55aed4859fde859082ac
Gitweb:        https://git.kernel.org/tip/4aca2d99fd27698cf82d55aed4859fde859082ac
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 19 May 2021 15:52:47 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 11:24:07 +02:00

x86/sev: Fix error message in runtime #VC handler

The runtime #VC handler is not "early" anymore. Fix the copy&paste error
and remove that word from the error message.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210614135327.9921-2-joro@8bytes.org
---
 arch/x86/kernel/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 651b81c..4fd997b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1369,7 +1369,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 		vc_finish_insn(&ctxt);
 		break;
 	case ES_UNSUPPORTED:
-		pr_err_ratelimited("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+		pr_err_ratelimited("Unsupported exit-code 0x%02lx in #VC exception (IP: 0x%lx)\n",
 				   error_code, regs->ip);
 		goto fail;
 	case ES_VMM_ERROR:
