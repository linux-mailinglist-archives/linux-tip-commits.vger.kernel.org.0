Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D4C327DDA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhCAMIH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 07:08:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58914 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhCAMIF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 07:08:05 -0500
Date:   Mon, 01 Mar 2021 12:07:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614600441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eydlmhsj2dW8ca+vM6O/qYgUuk81LRTFPhF9FNqZsk0=;
        b=MgZTOumz9Y4dUgKMYiThAwryGBRcaeTVaI9iXl30uEe5EyZVR6dhlxPnjhWJ96xCDS89Z0
        7gmyphqTnLEbaborNhRFX/tjII5kxzcahSoG7aBOrxYM+xyvA2RA06ssW6ypXjQOxFk+71
        nEZT5PrU5MMmg1Y4SmIRLWPbde60f7/dogsKBCL5ZU9CLkDi6nMgM5SmWbmypwVQADWCEo
        TdqKM1cMlUhFDV+OmQuq7zEN0QYtnv1G4B9TcykZefVaEAl4mTNrGqOoTeEyB7f3xiUWbo
        EXMuldfpYZkG0L5A1vpQuOlkL3dpPF6EJ92KZNbGnVmFng8UKinvSItkmdV2qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614600441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eydlmhsj2dW8ca+vM6O/qYgUuk81LRTFPhF9FNqZsk0=;
        b=Gvxcn/WThPZxAW+Wg+mQcbbyBGADOf3lRvKyz3lTRSXJVQYiqmbqyFFQigPZqcJT1VT7ea
        2ucs+m1OISAZIZAA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Remove subtraction of res variable
Cc:     Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210223111130.16201-1-bp@alien8.de>
References: <20210223111130.16201-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161460044051.20312.6762065762285788103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     bb8dc26937d51b3421b26d9d91cdad3484c34b7e
Gitweb:        https://git.kernel.org/tip/bb8dc26937d51b3421b26d9d91cdad3484c34b7e
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 23 Feb 2021 12:03:19 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 01 Mar 2021 12:40:22 +01:00

x86/sev-es: Remove subtraction of res variable

vc_decode_insn() calls copy_from_kernel_nofault() by way of
vc_fetch_insn_kernel() to fetch 15 bytes max of opcodes to decode.

copy_from_kernel_nofault() returns negative on error and 0 on success.
The error case is handled by returning ES_EXCEPTION.

In the success case, the ret variable which contains the return value is
0 so there's no need to subtract it from MAX_INSN_SIZE when initializing
the insn buffer for further decoding. Remove it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20210223111130.16201-1-bp@alien8.de
---
 arch/x86/kernel/sev-es.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 84c1821..1e78f4b 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -267,7 +267,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
 		insn_get_length(&ctxt->insn);
 	}
 
