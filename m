Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC16F30C440
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhBBPpV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 10:45:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37278 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbhBBPoS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 10:44:18 -0500
Date:   Tue, 02 Feb 2021 15:43:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612280612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgu7rYUFJeaN3tHI99Z6D+O5yD4JWfCgVt9q75Jw8jo=;
        b=ycubcBsV2Ivr/N1Yu5Kc5CFe5gwOdmqboUCuy2zFStK7AaOuHRLxEZcpgo8SCstek39MZh
        KIUydyS+9n68ofX+DFKGbbhUwcHP7t1zjfalEkQ6YzalgQqckZIvbp05mdfEswsqYFgNh+
        zEmYQz+97Y6SbFdrtgr7gTkbT4ZbsBsWghzLI3JVto6uj0PMDJCIPVB5CaV8cUVMJuGyZZ
        FRH/PutNB1UrMqTZE5/uHQHZGor9GgDRrIWuXO31mABQn+GNOhMoLMUZ8GCbmgf1cM9t4z
        /P6/MJWpbRv2aQwIYlSrweeIvk6UeWlhjBpR0oThKBpmNtIf8AhJXd/TdEz92w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612280612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgu7rYUFJeaN3tHI99Z6D+O5yD4JWfCgVt9q75Jw8jo=;
        b=McWaUP/NaQcZLtZs/3HxmVn9El+t+1WPV0KwMDDw92ZKqeac+FbEQRwa2zud8PPqWrBr68
        xPBog44THRotNHCA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Do not unroll string I/O for SEV-ES guests
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3de04b5b638546ac75d42ba52307fe1a922173d3=2E16122?=
 =?utf-8?q?03987=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C3de04b5b638546ac75d42ba52307fe1a922173d3=2E161220?=
 =?utf-8?q?3987=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <161228060225.23325.15092901811831050332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     62a08a7193dc9107904aaa51a04ba3ba2959f745
Gitweb:        https://git.kernel.org/tip/62a08a7193dc9107904aaa51a04ba3ba2959f745
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 01 Feb 2021 12:26:27 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 02 Feb 2021 16:25:05 +01:00

x86/sev-es: Do not unroll string I/O for SEV-ES guests

Under the GHCB specification, SEV-ES guests can support string I/O.
The current #VC handler contains this support, so remove the need to
unroll kernel string I/O operations. This will reduce the number of #VC
exceptions generated as well as the number VM exits for the guest.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/3de04b5b638546ac75d42ba52307fe1a922173d3.1612203987.git.thomas.lendacky@amd.com
---
 arch/x86/mm/mem_encrypt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c79e573..d55ea77 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -474,9 +474,10 @@ void __init mem_encrypt_init(void)
 	swiotlb_update_mem_attributes();
 
 	/*
-	 * With SEV, we need to unroll the rep string I/O instructions.
+	 * With SEV, we need to unroll the rep string I/O instructions,
+	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (sev_active())
+	if (sev_active() && !sev_es_active())
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
