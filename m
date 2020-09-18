Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BFD26F85A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIRIbz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:31:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRIa6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:58 -0400
Date:   Fri, 18 Sep 2020 08:30:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPplkmaOtUB9eN2pZ4gDdPV5Ijo8tZlzpgcu8ksrw88=;
        b=RZRECHlo7oCTFw47ZYhi0dAYerQMMNFzPGcFgwlDMF+MLjr8OokGZzcrTM4ohUqmg7D8el
        aniR+8duUL04F2uyVZ8mv/7oqlM3Tb6y8np77k+AIVyrJKZPYOmVuLLdd6kLEsZ4JwGqvO
        kR2/SWhbqY+3t7HgGaBN5xQNNjY6iwHzRDLex7Zu7ycdSEy13o1G9P+imjEZmBS6Q19oDz
        2dwlgq+ZMDIe5u8nG3HX/H/Bo9X9NkUQEBqsb0nE1fUAwrwoO0eamyzmjKfFHDh79afv0Q
        iJ5u80J2TQusqXf+W1hfweMmgZhh0lIlldqnJx2Eg/z/43qpuAfDdnwvUbAErA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPplkmaOtUB9eN2pZ4gDdPV5Ijo8tZlzpgcu8ksrw88=;
        b=pZIVLLZqmipWpDnXbGqCOtVBjcCHf5OCUv8AgpksEjbwG21cSQo4YOeBJEVCFmE5L4uJ5f
        ygunCsPsjkJasRBg==
From:   "tip-bot2 for Tian Tao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/printf: remove unneeded semicolon
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1599633872-36784-1-git-send-email-tiantao6@hisilicon.com>
References: <1599633872-36784-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Message-ID: <160041785566.15536.3114062822884187461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     5c4c30f40ca246f83b6663984dcdcbfeb0f8b66f
Gitweb:        https://git.kernel.org/tip/5c4c30f40ca246f83b6663984dcdcbfeb0f8b66f
Author:        Tian Tao <tiantao6@hisilicon.com>
AuthorDate:    Wed, 09 Sep 2020 14:44:32 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:53:42 +03:00

efi/printf: remove unneeded semicolon

Fix the warning below.
efi/libstub/vsprintf.c:135:2-3: Unneeded semicolon

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/1599633872-36784-1-git-send-email-tiantao6@hisilicon.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/vsprintf.c b/drivers/firmware/efi/libstub/vsprintf.c
index e65ef49..1088e28 100644
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -135,7 +135,7 @@ char *number(char *end, unsigned long long num, int base, char locase)
 		break;
 	default:
 		unreachable();
-	};
+	}
 
 	return end;
 }
