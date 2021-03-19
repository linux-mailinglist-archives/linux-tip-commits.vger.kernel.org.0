Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C8341CF4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSMba (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 08:31:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhCSMbX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 08:31:23 -0400
Date:   Fri, 19 Mar 2021 12:31:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616157082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ta6TbYc2KpxX9Gx0eKTed3N1z7DwvwubHJrt1xszU8w=;
        b=xegow6TB2ptZo7yiaEQFzsY//u+m5BF3Z9Zt3/gGqZ2j6uTICFb9Hi67Fde7D2nf9G/3+F
        maXU+RFr1tD9rp5RDO3q566xAzZjBF6ezewqEXN7j2pk7SDhxU4jXyMzz73eR07tplvmg4
        UyqcH1Kum8C24BkTlZPVotqtzeDVCSH08s9afgKYAaI06dBVxx4CiWfnZ58bNA3tnwL/JK
        ecgtTwENnKk0cp1iXWrh4SRDYkOxE7l+HIGHNGkNEgj9d4yrJwPWs/VW5DcdFhCNBDAPAV
        YgMG4cVoglK/YiS3BSk2sAFbgZ9OFbIFQetg7Ghqv4RRdYCe/S4lBDqAg6Uh5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616157082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ta6TbYc2KpxX9Gx0eKTed3N1z7DwvwubHJrt1xszU8w=;
        b=/jZD7+J4c6MmBq1r04qAIXozhJgLPakNPBnoRhXd8Fqt8DrKcdRR8MNjnW+UDcIbly4flW
        tM7EhWR7XEx9dYBg==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/kaslr: Return boolean values from a function
 returning bool
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1615283963-67277-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1615283963-67277-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <161615708162.398.13397477159993396875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     21d6a7dcbfba5e7b31f4e9d555a9be362578bfc3
Gitweb:        https://git.kernel.org/tip/21d6a7dcbfba5e7b31f4e9d555a9be362578bfc3
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Tue, 09 Mar 2021 17:59:23 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 19 Mar 2021 13:25:07 +01:00

x86/kaslr: Return boolean values from a function returning bool

Fix the following coccicheck warnings:

  ./arch/x86/boot/compressed/kaslr.c:642:10-11: WARNING: return of 0/1 in
  function 'process_mem_region' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1615283963-67277-1-git-send-email-jiapeng.chong@linux.alibaba.com
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b92fffb..e366907 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -639,9 +639,9 @@ static bool process_mem_region(struct mem_vector *region,
 
 		if (slot_area_index == MAX_SLOT_AREA) {
 			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
-			return 1;
+			return true;
 		}
-		return 0;
+		return false;
 	}
 
 #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
