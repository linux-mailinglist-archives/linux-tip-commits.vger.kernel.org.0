Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BD6375385
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhEFMPO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 08:15:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhEFMPH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 08:15:07 -0400
Date:   Thu, 06 May 2021 12:14:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620303248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3KwrhWFn7eF11gXaAnwDdvE67vhJy0acLxDWYfK2n8=;
        b=Jo0skTtGRGDEewlJmb4u3hD8wIJ8cs6UsY2vcK5Nv8GK7Bk7jz/ITR7/HU2rorTua17Umm
        +nEuMN6aN9yKc7pGDUpe65yqBe8+hKSn8FXT6/QlNmKzAPRZT5k/mb85xNnrCw6htZtxOg
        YCzKMrBupK3fy20Fm0ZUZ5KoobZgkPbuCBXujtD2lcmL5sPCrz2+5kGx6rX2BPN/VtFO6w
        qBbKULbAatIGOxXzil0xDRu7Ua/vtHPeqTK/J6ozrlUuws/EdJQCVbUmJMZJhhwjGyrqPj
        PG6zHyToQL2bOkiQlbWDJTVdYD29ZmrQKhBsjlqw5sAAxrSo4vR5oGeIvDTUQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620303248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3KwrhWFn7eF11gXaAnwDdvE67vhJy0acLxDWYfK2n8=;
        b=cRYmhOw6yVLpGROuBuwHD03Q6NvPny4crROb8fxJ8kpGPyTCfW+CH6unshUAGeqi9VUfLQ
        cI6nvF9eK3FZfXAg==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Delete UD0, UD1 traces
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YIHHYNKbiSf5N7+o@localhost.localdomain>
References: <YIHHYNKbiSf5N7+o@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <162030324799.29796.9740974836121590926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     790d1ce71de9199bf9fd37c4743aec4a09489a51
Gitweb:        https://git.kernel.org/tip/790d1ce71de9199bf9fd37c4743aec4a09489a51
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Thu, 22 Apr 2021 21:58:40 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 05 May 2021 21:50:13 +02:00

x86: Delete UD0, UD1 traces

Both instructions aren't used by kernel.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YIHHYNKbiSf5N7+o@localhost.localdomain

---
 arch/x86/include/asm/bug.h |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 297fa12..84b8753 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -7,18 +7,9 @@
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
- *
- * Since various instruction decoders/specs disagree on the encoding of
- * UD0/UD1.
  */
-
-#define ASM_UD0		".byte 0x0f, 0xff" /* + ModRM (for Intel) */
-#define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
 #define ASM_UD2		".byte 0x0f, 0x0b"
-
-#define INSN_UD0	0xff0f
 #define INSN_UD2	0x0b0f
-
 #define LEN_UD2		2
 
 #ifdef CONFIG_GENERIC_BUG
