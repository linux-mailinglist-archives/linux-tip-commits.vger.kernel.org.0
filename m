Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FDE23E49E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Aug 2020 01:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHFXkP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 19:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgHFXiy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94CC061574;
        Thu,  6 Aug 2020 16:38:54 -0700 (PDT)
Date:   Thu, 06 Aug 2020 23:38:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1XXp605aGxxr/0aEn98rrSVj5Uicg0XvYrQe16vMEY=;
        b=wRUDHkUm5S0p6EhHc9O3P6C8+evO2O7X6R8UQTTyUPUVQd+0ghvWG+2C+g+NDrBfG83NBY
        R5O8P7BDuYNTPk+ynaB5y8mKz3ZRh+F4AEkBowENbAPs8JkxXZiWrrAcsL5zGvUHjI2hsW
        WqsU2A775Aes++f2JEQrEWjDZ+hz+2LVB+pnU08g+9QCN0r1WooCO4ffaPPmh6HDNitsS4
        EKb74jM0WwcWAz318tIBXziQilucz+JyLGPhgGZ4RMrTcStGoQfqwhM5hhFdWZdse1FiyJ
        Fnecgpg97CyZdhXOXQGUpMlyasEtCVMuXiTecNMZX2oS9cK+m8PoSFSw0ztb7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1XXp605aGxxr/0aEn98rrSVj5Uicg0XvYrQe16vMEY=;
        b=9gsuhy92jOkdY/z8nYkzhItewmVw6AUgHkQv9qhP04wwBTAe+hIVuGg/l5DpZgSfWhZR/2
        mOZXOeDZXR6F88AA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kaslr] x86/kaslr: Make minimum/image_size 'unsigned long'
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728225722.67457-19-nivedita@alum.mit.edu>
References: <20200728225722.67457-19-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159675713240.3192.15831232343874338979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/kaslr branch of tip:

Commit-ID:     e4cb955bf173474a61f56200610004aacc7a62ff
Gitweb:        https://git.kernel.org/tip/e4cb955bf173474a61f56200610004aacc7a62ff
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 28 Jul 2020 18:57:19 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 Jul 2020 11:08:17 +02:00

x86/kaslr: Make minimum/image_size 'unsigned long'

Change type of minimum/image_size arguments in process_mem_region to
'unsigned long'. These actually can never be above 4G (even on x86_64),
and they're 'unsigned long' in every other function except this one.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200728225722.67457-19-nivedita@alum.mit.edu
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index ecdf33d..3244f5b 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -649,8 +649,8 @@ static void __process_mem_region(struct mem_vector *entry,
 }
 
 static bool process_mem_region(struct mem_vector *region,
-			       unsigned long long minimum,
-			       unsigned long long image_size)
+			       unsigned long minimum,
+			       unsigned long image_size)
 {
 	int i;
 	/*
