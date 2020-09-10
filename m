Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421DC264191
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 11:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgIJJXF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 05:23:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbgIJJWT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:19 -0400
Date:   Thu, 10 Sep 2020 09:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnXv12gGBDaSrD0ETKCH4ffZcRC1dqZFTwndZAy2Q/4=;
        b=duPmDBMfMRTAcuacqlRsOjLHbyWJA2lDIOHNW9hKeHD/tPLK5OoLwI+w/wLfGuM8QWLeZa
        ryhJf1Nmn/YTpHaNcoSYkjNmpc6WDwqhd500Hf7WbWEdzz0llgVX/utGX5qFdh+ou2rz5c
        Zr2dcx0e9DlQm96pQQkjpYUNEwIwLm1BC6pFRY/IlOjZ8xkPLX8qM36AOpyoEZowQdJ802
        B2HxdJ1CAEAYyuoqLs7ng0ShUm6SiAOYQuf7DqMYBKs21KTM/9OOr3GRGiU+F3pJ2sY0E4
        6+KS7P0734JeXjUa/3Q5PStbteQc6gbvMd/LoXpE5C1vCNoENCLU0clgK38qIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnXv12gGBDaSrD0ETKCH4ffZcRC1dqZFTwndZAy2Q/4=;
        b=StVpUaqlQe+FQnCFYtdqs1MevyxK+opsL4vs1BQOS+KpVHPNN1GE5d1PtzoPdzCxfHuMzn
        Q1jSUOxJKHTDlLDg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle INVD Events
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-57-joro@8bytes.org>
References: <20200907131613.12703-57-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972887.20229.4347569173529097534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     8b4ce83707cb2cff5f6d175ea38f751ac4456096
Gitweb:        https://git.kernel.org/tip/8b4ce83707cb2cff5f6d175ea38f751ac4456096
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:57 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/sev-es: Handle INVD Events

Implement a handler for #VC exceptions caused by INVD instructions.
Since Linux should never use INVD, just mark it as unsupported.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to #VC handling infrastructure ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-57-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index b2d7287..236cfc1 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -892,6 +892,10 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_RDPMC:
 		result = vc_handle_rdpmc(ghcb, ctxt);
 		break;
+	case SVM_EXIT_INVD:
+		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
+		result = ES_UNSUPPORTED;
+		break;
 	case SVM_EXIT_CPUID:
 		result = vc_handle_cpuid(ghcb, ctxt);
 		break;
