Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0680201802
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Jun 2020 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbgFSQqK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Jun 2020 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405038AbgFSQqD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A593C0613F0;
        Fri, 19 Jun 2020 09:46:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9Q-00044M-DH; Fri, 19 Jun 2020 18:46:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0D6B81C032F;
        Fri, 19 Jun 2020 18:46:00 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:45:59 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Fix missing-prototype warning for
 skip_spaces()
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159258515978.16989.8538680304687702182.tip-bot2@tip-bot2>
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

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     24552d10339f13d2174e013002da3ed90e26adda
Gitweb:        https://git.kernel.org/tip/24552d10339f13d2174e013002da3ed90e26adda
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 15 Jun 2020 12:31:14 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 15 Jun 2020 19:43:58 +02:00

efi/libstub: Fix missing-prototype warning for skip_spaces()

Include <linux/string.h> into skip_spaces.c to silence a compiler
warning about a missing prototype.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/skip_spaces.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/libstub/skip_spaces.c b/drivers/firmware/efi/libstub/skip_spaces.c
index a700b3c..159fb4e 100644
--- a/drivers/firmware/efi/libstub/skip_spaces.c
+++ b/drivers/firmware/efi/libstub/skip_spaces.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 char *skip_spaces(const char *str)
