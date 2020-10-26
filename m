Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2E298BF4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 12:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773394AbgJZLW5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 07:22:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773330AbgJZLW4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 07:22:56 -0400
Date:   Mon, 26 Oct 2020 11:22:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603711374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlgQvxHJfagEg4w+0Ui1Kt7r5/kLfd7VgkqNKdFX59U=;
        b=Z6rKe6l+N71MEdzyHyr5MGYXoVnZPhVcL5USsCCcnetj0e1ryg+LkguWPLGr0PWHFnIJpo
        swiWd94YAy0pqvGJzEP8P35FyNZC9x7gZZ9+NnlEbHWOTgTCsHKY/oylnOIL+BuLWBhfGV
        HFbxM5R5jZRdSDDZbsMbys0SUB1wYy6UXG0Csl7ob0FiE4/AQ6yt1EzXAXLb1STku7/6xj
        ErDRNzv6k3S5ujGWRcLGNwNKaTKImQPQhVMbar5IZPg6AXA7EMVmN5blp1MOsf8FYjFAzX
        Lrq9AHjbLU7DDEdcSfPgs9nS2B9H3Ye3jqdm88O1R/mkSVbXfZz4qdqZgGHSCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603711374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlgQvxHJfagEg4w+0Ui1Kt7r5/kLfd7VgkqNKdFX59U=;
        b=/pwggzwKVzOHNixdpoB8Ez187b1X0oy6Ipr4pXTduOJwK0eFOZzx11gx8Su2a2z69m4fJD
        PcNC4d4LtIuNKaAw==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Remove unneeded break
Cc:     Tom Rix <trix@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201019200629.17247-1-trix@redhat.com>
References: <20201019200629.17247-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <160371137356.397.16490477068432829900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     880396c86a1f3663c22b74fef34353f05a1263ec
Gitweb:        https://git.kernel.org/tip/880396c86a1f3663c22b74fef34353f05a1263ec
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Mon, 19 Oct 2020 13:06:29 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 26 Oct 2020 12:18:22 +01:00

x86/microcode/amd: Remove unneeded break

A break is not needed if it is preceded by a return.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201019200629.17247-1-trix@redhat.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3f6b137..3d4a483 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -215,7 +215,6 @@ static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size
 	default:
 		WARN(1, "%s: WTF family: 0x%x\n", __func__, family);
 		return 0;
-		break;
 	}
 
 	if (sh_psize > min_t(u32, buf_size, max_size))
