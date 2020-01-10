Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A73137599
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Jan 2020 18:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgAJR7V (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Jan 2020 12:59:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgAJR7V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ5-000294-GH; Fri, 10 Jan 2020 18:59:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 186AA1C2D6B;
        Fri, 10 Jan 2020 18:59:19 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:18 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Fix typo in the Kconfig help text
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867915892.30329.10210148891271849297.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b75baaf3a81e71680f3d50965c9330b36993fbad
Gitweb:        https://git.kernel.org/tip/b75baaf3a81e71680f3d50965c9330b36993fbad
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 15:57:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Fix typo in the Kconfig help text

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..b677857 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1512,7 +1512,7 @@ config X86_CPA_STATISTICS
 	bool "Enable statistic for Change Page Attribute"
 	depends on DEBUG_FS
 	---help---
-	  Expose statistics about the Change Page Attribute mechanims, which
+	  Expose statistics about the Change Page Attribute mechanism, which
 	  helps to determine the effectiveness of preserving large and huge
 	  page mappings when mapping protections are changed.
 
