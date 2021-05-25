Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED9390469
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhEYPCX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhEYPCX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 11:02:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C38C061756;
        Tue, 25 May 2021 08:00:53 -0700 (PDT)
Date:   Tue, 25 May 2021 15:00:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621954851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rx3rpqcpHtxpXAaoCgNpBJo48kMaT+i+UluAs1BWMWk=;
        b=Rtvb9biYZn4Vd64t7XBNZfSTVsSNTyBlhvv8kspx6YxO65nM1sjl0bTAr3DkN/h5UibPAf
        9o4JxNm81xz2HteyotEY+cBflNe0+zOHViimIpa9FOM/YAz+xb2oMGzk72rRgEq6MbnUBz
        IVhWiQ4I1mUfXgyBhq5Re4S6WG8blqBS1/e9ZaZvOlJcQJzj4r9371kT+2xuxMNAXbK0Zm
        ly+Zsyg0e38vS7TOgzQ+Eq5f1pye/utKgpGStcoCxpDsaz6rumLm9GDi7z1HjQ2P/k8oPS
        HkbY+HulSHkGEifZG8rIl4nNbYrzR3MuQIquvGz57dTVflzYfjSy+aeAPibcfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621954851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rx3rpqcpHtxpXAaoCgNpBJo48kMaT+i+UluAs1BWMWk=;
        b=FRzw9t/4vD0NwQVevADmrLOxF4g1xq6WqYIEpYR+I1I7DCzJDebQkVT1T8jKRdZloP3wva
        Kj19h6Oq/+8PiwBQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/syscalls: Remove -Wno-override-init for syscall tables
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524181707.132844-3-brgerst@gmail.com>
References: <20210524181707.132844-3-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <162195485119.29796.17562487645005945629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     fd9e8691f38712892fa2ac73132dcc8b85b07a8f
Gitweb:        https://git.kernel.org/tip/fd9e8691f38712892fa2ac73132dcc8b85b07a8f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 24 May 2021 14:17:06 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 May 2021 16:59:23 +02:00

x86/syscalls: Remove -Wno-override-init for syscall tables

Commit 44fe4895f47c ("Stop filling syscall arrays with *_sys_ni_syscall")
removes the need for -Wno-override-init, since the table is now filled
sequentially instead of overriding a default value.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20210524181707.132844-3-brgerst@gmail.com

---
 arch/x86/entry/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 08bf95d..94d2843 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -17,10 +17,6 @@ CFLAGS_syscall_64.o		+= -fno-stack-protector
 CFLAGS_syscall_32.o		+= -fno-stack-protector
 CFLAGS_syscall_x32.o		+= -fno-stack-protector
 
-CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
-CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
-CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
-
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
