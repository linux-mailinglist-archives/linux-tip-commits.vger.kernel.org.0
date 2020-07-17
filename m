Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A24223EC8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGQOvk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgGQOvN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DFEC0619D3;
        Fri, 17 Jul 2020 07:51:12 -0700 (PDT)
Date:   Fri, 17 Jul 2020 14:51:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CskPa9RPcNfozLy8UejoC3ZnVNx6pQobsO/ElT203cM=;
        b=kTTgFNTbEV0d2nibjcYTq3i28qFWozvSxjKjM5V5lsrV/II8LD+/OWcCTyU1KsQgCvaqjj
        skiTsxdshEGQljxz+BZV/k1EkoLcZVEJxrQypxLhq4t7fHDdwT8CPr/ZCHdD6NewJ5xhdn
        IttLqTmpTzhFv2kORCo09eZXR+p4NyjsXLSLsEqOSVs0z1qLP4G3loBzlHBsK2uupENM2+
        a3LmHOsjQ5f/DpIfmZTm5pI8i1TA8SCsJWub+i7+iC8J2ZjzBJ0Xgn3goudKKdlmy3Gwfj
        khLqkIWGKmAyCi53PSFU7WFbsXIiDA7xzmsuoVMMN6fmxoFPE4AG3QTYJeo55g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CskPa9RPcNfozLy8UejoC3ZnVNx6pQobsO/ElT203cM=;
        b=THod4kPMqr803YMPvIxJsvsO0y1noBYCPQun1zTCeQwwvHt2D2IueFsSmzcmTefGL63Z7s
        sIiO754a2zQko0BA==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove support for UV1 platform from uv
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212955.320087418@hpe.com>
References: <20200713212955.320087418@hpe.com>
MIME-Version: 1.0
Message-ID: <159499747007.4006.10229652805128761175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     f584c75307f3b75a83e006b98c5718fc20797851
Gitweb:        https://git.kernel.org/tip/f584c75307f3b75a83e006b98c5718fc20797851
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:01 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:46 +02:00

x86/platform/uv: Remove support for UV1 platform from uv

UV1 is not longer supported by HPE

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200713212955.320087418@hpe.com

---
 arch/x86/include/asm/uv/uv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 3db8562..e48aea9 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -4,7 +4,7 @@
 
 #include <asm/tlbflush.h>
 
-enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC, UV_NON_UNIQUE_APIC};
+enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC};
 
 struct cpumask;
 struct mm_struct;
