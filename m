Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26117446405
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Nov 2021 14:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhKENWn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Nov 2021 09:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhKENWf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Nov 2021 09:22:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D9FC06120D;
        Fri,  5 Nov 2021 06:19:41 -0700 (PDT)
Date:   Fri, 05 Nov 2021 13:19:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636118380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p99QONqqFlhmJhGB4cU3v/TOmqtcFhGoVJvHxocSo/k=;
        b=SPHiRcyAnwiHJcOJ6ljv9RWoxBo3FeldVPh1Y4c1wcVJqoqBPD9fTlg/cA+N/kIDchYVyC
        7xI56up8bxKSSyGD/1A4DCybzlOe//VCEUejc490JACAXSntDUdw/1Drq3KIgl0H7SIlYY
        MAMHire81zwm6RB19/If7zDSshfB/i8SYPghJevMF3TNMoOBuGId7fjpvcQ0uNMIZULaIA
        VknPprwThwRB7lKV6EZDi2UO1ChWURIPt1nMy5dgZubxeAjLqAykkOpgCQyh8wfG8Rac2G
        jP61tG+dRtAwNNbyu/5lW+4jI9E6AQQmu4Z1P0y1lVafFYPKYa0n0gI9UxDrSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636118380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p99QONqqFlhmJhGB4cU3v/TOmqtcFhGoVJvHxocSo/k=;
        b=uX1fWfUjQRcLjmc6bVszOQL2flmi1/jkTJozBhX13P3FmBsRyTnwIV7+ERCwlA/2MaHnAx
        Dyjn6EL3GTRMhHAQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Add some information to PARAVIRT_OPS entry
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211104095955.4813-1-jgross@suse.com>
References: <20211104095955.4813-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <163611837895.626.6157744222328526514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     43d3b7f6a362c06a19f14ff432993780aaad7ffd
Gitweb:        https://git.kernel.org/tip/43d3b7f6a362c06a19f14ff432993780aaad7ffd
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 04 Nov 2021 10:59:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Nov 2021 14:16:44 +01:00

MAINTAINERS: Add some information to PARAVIRT_OPS entry

Most patches for paravirt_ops are going through the tip tree, as those
patches tend to touch x86 specific files a lot.

Add the x86 ML and the tip tree to the PARAVIRT_OPS MAINTAINERS entry
in order to reflect that.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20211104095955.4813-1-jgross@suse.com

---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96a96b1..0ad926b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14191,7 +14191,9 @@ M:	Juergen Gross <jgross@suse.com>
 M:	Deep Shah <sdeep@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
+L:	x86@kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	Documentation/virt/paravirt_ops.rst
 F:	arch/*/include/asm/paravirt*.h
 F:	arch/*/kernel/paravirt*
