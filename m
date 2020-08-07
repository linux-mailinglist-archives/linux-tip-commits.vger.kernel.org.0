Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0723E49F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Aug 2020 01:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHFXkQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 19:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgHFXiw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C43C061575;
        Thu,  6 Aug 2020 16:38:52 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDxatrwO+co72myHzmJiVqhEcOcAAOjarE+tDUP3zz0=;
        b=rzKES9e0H1m5Nm6KXCA6vSDrWrdNJHMtiDPI/5LrnNgOggaF7wIoh74AoT5B65rK1j2YGa
        WHML9va4Uu+gWnMSVKQSemYzFa9DmsWSuXfeIdfvNYPcT122SI5D2DITvh61kWHpvk8+VB
        kvB4/+ZqejjuokyUC1/pZSHXKhTQMRL3xiIjjxlzLT7EJriZ5DJENYnfsoiRuIUQkwj0fB
        qSetmEqbttvWzhy5TE/upOJw2p1A6h4FxiO95Blhko0lod27CPwli9r/qlEd1flr+Iux6n
        avwM0yk2cMntgUxwUSQdYX7qrXD8Q6IVhpl5gsQtfZcB6xzUXxdUozKEXNrOOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDxatrwO+co72myHzmJiVqhEcOcAAOjarE+tDUP3zz0=;
        b=vIRQpDGmT0wZfMPayECEODhFEAxr/x4RCFzpOqM21Kk/qNBIy57BEcRnpyuxfs2VMBTLUt
        S4+3ucjKHYtSk3CQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Add a check that the random address is in range
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-22-nivedita@alum.mit.edu>
References: <20200728225722.67457-22-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713045.3192.895736711102672509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     f49236ae424d499d02ee3ce35fb9130ddf95b03f
Gitweb:        https://git.kernel.org/tip/f49236ae424d499d02ee3ce35fb9130ddf95b03f
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:22 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Add a check that the random address is in range

Check in find_random_phys_addr() that the chosen address is inside the
range that was required.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-22-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 80cdd20..735fcb2 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -803,6 +803,8 @@ static void process_e820_entries(unsigned long minimum,
 static unsigned long find_random_phys_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
+	u64 phys_addr;
+
 	/* Bail out early if it's impossible to succeed. */
 	if (minimum + image_size > mem_limit)
 		return 0;
@@ -816,7 +818,15 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 	if (!process_efi_entries(minimum, image_size))
 		process_e820_entries(minimum, image_size);
 
-	return slots_fetch_random();
+	phys_addr = slots_fetch_random();
+
+	/* Perform a final check to make sure the address is in range. */
+	if (phys_addr < minimum || phys_addr + image_size > mem_limit) {
+		warn("Invalid physical address chosen!\n");
+		return 0;
+	}
+
+	return (unsigned long)phys_addr;
 }
 
 static unsigned long find_random_virt_addr(unsigned long minimum,
