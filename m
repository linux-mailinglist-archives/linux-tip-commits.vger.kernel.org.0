Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7913890A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbhESOVC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbhESOU6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 10:20:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE77C06175F;
        Wed, 19 May 2021 07:19:37 -0700 (PDT)
Date:   Wed, 19 May 2021 14:19:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621433974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tv6VHC0cvOzL77WD6QTOfM2sgZtd5qre3bn11HXPdfU=;
        b=PeOUcHHbL/GQQlCNx3oEaIdf3gDPsi52HTAcTSHoGV74ny1v9S8Ao64BQor0Z6sbO7Y98e
        rdTSDhs5hg2ZUSjyOtbLeKqDekAUmKEi4iPVRJLikZH7rveM4Z/uY0g6QeNYULahUYtpjR
        rJMzlYc+/1qrk1jjUSjm+cQyXBmV7/Xg6LURgWJOKyK6SXoqMDYq1zUvQ3hULvLHxvCmhd
        cWFa6qCzigmu3FNu/S8prJSHAQs3uNDIp7Yb+8zUNt/68wsC16UMmSH/rafcWrItrY2fKy
        DIE2nCbra+Cd1YDNp9KOkozcTRAsEk8mJaFhEGI66j39g1ZleKNmG/yAhGUJQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621433974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tv6VHC0cvOzL77WD6QTOfM2sgZtd5qre3bn11HXPdfU=;
        b=cVtNgt2JOVb+W9R3YH+56VYwxphBRpL9ovUyn5bj/COKRqqNIbFVJgJ9SRf2D39MV3xarR
        9+roZG6gTMBRrFBQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] uapi/auxvec: Define the aux vector AT_MINSIGSTKSZ
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518200320.17239-2-chang.seok.bae@intel.com>
References: <20210518200320.17239-2-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <162143397372.29796.11777578099249865998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     7cd60e43a6def40ecb75deb8decc677995970d0b
Gitweb:        https://git.kernel.org/tip/7cd60e43a6def40ecb75deb8decc677995970d0b
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 18 May 2021 13:03:15 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 May 2021 11:40:15 +02:00

uapi/auxvec: Define the aux vector AT_MINSIGSTKSZ

Define AT_MINSIGSTKSZ in the generic uapi header. It is already used
as generic ABI in glibc's generic elf.h, and this define will prevent
future namespace conflicts. In particular, x86 is also using this
generic definition.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20210518200320.17239-2-chang.seok.bae@intel.com
---
 include/uapi/linux/auxvec.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/auxvec.h b/include/uapi/linux/auxvec.h
index abe5f2b..c7e502b 100644
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,5 +33,8 @@
 
 #define AT_EXECFN  31	/* filename of program */
 
+#ifndef AT_MINSIGSTKSZ
+#define AT_MINSIGSTKSZ	51	/* minimal stack size for signal delivery */
+#endif
 
 #endif /* _UAPI_LINUX_AUXVEC_H */
