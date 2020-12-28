Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308072E69BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Dec 2020 18:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgL1RcW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Dec 2020 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgL1RcW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Dec 2020 12:32:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A39C061793;
        Mon, 28 Dec 2020 09:31:41 -0800 (PST)
Date:   Mon, 28 Dec 2020 17:31:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609176699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbYt5ha6t/G78Q/Qi2TwNtvCP2zEJ9PJnFzzqSjT/z0=;
        b=BZp7UhMkJdy0rspPVRL9xEna3FWmmUhTjOVWb0PaF3C96xQx0kZeWQxqSkBsUxGuBVwKiz
        GKK7RNU8OPlkzV55HqJdxib2gCDQZjJzDTPBKf7LYWx6SAiNwxCgBK1z5y7c8hfN6t22w5
        JIkbxJK6q7ivlZTvsvOsOQfDKOKeJrRQTpxXes139uL3ApUaq2h6wByUanjHZVpbnZK5Kd
        2ExnnxS76UJgkA3+tS77Dn44hwroGaj8QZ5jS3xLLsQdBHk1QUzMxlwnE1fuOVG2qkvHPp
        uPMyV1w/4NZiHGz3pFzSRiqWg78/TND8nTqQzDMayG6YBI7ypizLt8kIc/sZpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609176699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gbYt5ha6t/G78Q/Qi2TwNtvCP2zEJ9PJnFzzqSjT/z0=;
        b=Y8iRMlmqabvYc4boQIKoaKlm7EjBBkibn3qmW74pFF6HmgeGtY1XChQ5k1nHt1fpWWCuD6
        x26GPN+uq9FzalBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Add {kvm_guest,xen}.config targets to
 make help's output
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201217134608.31811-1-bp@alien8.de>
References: <20201217134608.31811-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160917669805.414.15671728042538230971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     fbaf0aa8c7a8d4f7c3e4664f2f03ec8c7cc79910
Gitweb:        https://git.kernel.org/tip/fbaf0aa8c7a8d4f7c3e4664f2f03ec8c7cc79910
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 17 Dec 2020 13:13:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 28 Dec 2020 18:23:25 +01:00

x86/build: Add {kvm_guest,xen}.config targets to make help's output

Add the targets which add additional items to the .config which
facilitate running the kernel as a guest, to the 'make help' output so
that they can be found easier and there's no need to grep the tree each
time to remember what they should be called.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201217134608.31811-1-bp@alien8.de
---
 arch/x86/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7116da3..3dae5c9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -304,4 +304,7 @@ define archhelp
   echo  '                  bzdisk/fdimage*/isoimage also accept:'
   echo  '                  FDARGS="..."  arguments for the booted kernel'
   echo  '                  FDINITRD=file initrd for the booted kernel'
+  echo  '  kvm_guest.config - Enable Kconfig items for running this kernel as a KVM guest'
+  echo  '  xen.config	  - Enable Kconfig items for running this kernel as a Xen guest'
+
 endef
