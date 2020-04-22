Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166881B4D1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Apr 2020 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgDVTNe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 15:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726444AbgDVTNe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 15:13:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E0C03C1AA;
        Wed, 22 Apr 2020 12:13:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRKoK-00073W-HF; Wed, 22 Apr 2020 21:13:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 074B41C0450;
        Wed, 22 Apr 2020 21:13:28 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:13:27 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm/mmap: Fix -Wmissing-prototypes warnings
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402124307.10857-1-b.thiel@posteo.de>
References: <20200402124307.10857-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <158758280764.28353.1786440205959432306.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     60abfd08e88b2b41366dcdb1e586614770c791fa
Gitweb:        https://git.kernel.org/tip/60abfd08e88b2b41366dcdb1e586614770c791fa
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Thu, 02 Apr 2020 14:43:07 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Apr 2020 20:19:48 +02:00

x86/mm/mmap: Fix -Wmissing-prototypes warnings

Add includes for the prototypes of valid_phys_addr_range(),
arch_mmap_rnd() and valid_mmap_phys_addr_range() in order to fix
-Wmissing-prototypes warnings.

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200402124307.10857-1-b.thiel@posteo.de
---
 arch/x86/mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index cb91ecc..c90c209 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -18,7 +18,9 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/compat.h>
+#include <linux/elf-randomize.h>
 #include <asm/elf.h>
+#include <asm/io.h>
 
 #include "physaddr.h"
 
