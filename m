Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82284415B67
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Sep 2021 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbhIWJwO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Sep 2021 05:52:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbhIWJwO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Sep 2021 05:52:14 -0400
Date:   Thu, 23 Sep 2021 09:50:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632390642;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Av5N3SltN+DMzp6ebBiml+GcQWR0bLIu9w6DuzFVCY=;
        b=yDVtD5WkUtaphuOJwZzHX2ToqDq0wFhysAQFZBjiBxQY/nNx75nMSnfaj2rsVZKXJa5Zlt
        zF9DIt7Y5wRLBgf38StKoGvzmXLXJof4WHvIpTrFxg7Wfme1Tp9iaHR8BBEb79HL+i2Ji6
        ipCVF8wjqjtCo/kMFDxqKpoFEkRBXWNbVcFy/lREf7aTOBAm5PSKDgUfT0W2Cqmg8To5FX
        POqwyXQoYDxrisvbCEpmrnOClPUUBD0i5B6LJ52HyRqcq4ZlYRHEFZnhVGjwzkgSvqpOAa
        4nrZAW/BVDl8hyFXcGC8itbiSTn7TyLwHN0mrwAZaWJ/HZQ+7SJ607TZKm8dtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632390642;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Av5N3SltN+DMzp6ebBiml+GcQWR0bLIu9w6DuzFVCY=;
        b=SVibWTRg2g+xSoa335aDrltD7fYEDhpmxwKqYQowC7fqXduSE0hC4ZQjBVJhJinZQ7WuKa
        gUM93Mavw1NPNfDw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Sort mca_config members to get rid of
 unnecessary padding
Cc:     Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210922165101.18951-6-bp@alien8.de>
References: <20210922165101.18951-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163239064090.25758.15366322469006879108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     15802468a95bd8ec9060eb861468f4a0f0106fa4
Gitweb:        https://git.kernel.org/tip/15802468a95bd8ec9060eb861468f4a0f0106fa4
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 22 Sep 2021 18:44:17 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Sep 2021 11:38:04 +02:00

x86/mce: Sort mca_config members to get rid of unnecessary padding

$ pahole -C mca_config arch/x86/kernel/cpu/mce/core.o

before:

   /* size: 40, cachelines: 1, members: 16 */
   /* sum members: 21, holes: 1, sum holes: 3 */
   /* sum bitfield members: 64 bits, bit holes: 2, sum bit holes: 32 bits */
   /* padding: 4 */
   /* last cacheline: 40 bytes */

after:

   /* size: 32, cachelines: 1, members: 16 */
   /* padding: 3 */
   /* last cacheline: 32 bytes */

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20210922165101.18951-6-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/internal.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 2186554..37b9e38 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -113,11 +113,6 @@ static inline void mce_unregister_injector_chain(struct notifier_block *nb)	{ }
 #endif
 
 struct mca_config {
-	bool dont_log_ce;
-	bool cmci_disabled;
-	bool ignore_ce;
-	bool print_all;
-
 	__u64 lmce_disabled		: 1,
 	      disabled			: 1,
 	      ser			: 1,
@@ -127,11 +122,16 @@ struct mca_config {
 	      initialized		: 1,
 	      __reserved		: 58;
 
-	s8 bootlog;
+	bool dont_log_ce;
+	bool cmci_disabled;
+	bool ignore_ce;
+	bool print_all;
+
 	int tolerant;
 	int monarch_timeout;
 	int panic_timeout;
 	u32 rip_msr;
+	s8 bootlog;
 };
 
 extern struct mca_config mca_cfg;
