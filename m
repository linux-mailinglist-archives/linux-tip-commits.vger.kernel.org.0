Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB23EA2D5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhHLKMF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhHLKKQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 06:10:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB399C06179B;
        Thu, 12 Aug 2021 03:09:45 -0700 (PDT)
Date:   Thu, 12 Aug 2021 10:09:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628762984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EojEC9l2IEqu33hC1E1/r59YGBpO0jV1pcmU2rY27/A=;
        b=BH6Y4lgJdFbgEH98fcTJF8V7SMEeF0Z9rwMQrH6jEtEi9n8aTFrXmQoauPKFkBz3vsdnTs
        e9JwncsGhko6J3+/a9smFa2mtXgkADks3uBJXdjRuvZHBK6vTgJ4A7fuMFrLR6ULmdiM4d
        xF46F5f2j29Ci/UFhKR8f8E+M5Xyex5KN2w9EuJrnSizKnac+TS3vAZXcMXTcgG6dOzSMm
        cCXLjCFn1eGzb7ojmBcbMI1IJauu1X0JpBU6RX/a8x+E0mVCWSfMv24EZwd5YbO9bHd1Hu
        LRa/+ISvwGCITC5iHOE+3AdoveLwZuldxEnzx+YyVR9D8j1gNgDYmIzSjiTfLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628762984;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EojEC9l2IEqu33hC1E1/r59YGBpO0jV1pcmU2rY27/A=;
        b=K/C0iZnbVwh+PUVkduI+hp4Pms50x53lCNvlINQXq3pZCBlTKNxfgvfjDzkeAriDTBFR2N
        JA17qK0E/CiIWzDA==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/reboot: Document the "reboot=pci" option
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210530162447.996461-2-paul.gortmaker@windriver.com>
References: <20210530162447.996461-2-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Message-ID: <162876298363.395.15945425696843293640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     162a5284faf41b2441b8f686f9ac4771c7a8f669
Gitweb:        https://git.kernel.org/tip/162a5284faf41b2441b8f686f9ac4771c7a8f669
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 30 May 2021 12:24:45 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Aug 2021 12:06:58 +02:00

x86/reboot: Document the "reboot=pci" option

It is mentioned in the top level non-arch specific file but it was
overlooked here for x86.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210530162447.996461-2-paul.gortmaker@windriver.com

---
 Documentation/x86/x86_64/boot-options.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 5f62b3b..482f3b2 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -126,7 +126,7 @@ Idle loop
 Rebooting
 =========
 
-   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
+   reboot=b[ios] | t[riple] | k[bd] | a[cpi] | e[fi] | p[ci] [, [w]arm | [c]old]
       bios
         Use the CPU reboot vector for warm reset
       warm
@@ -145,6 +145,8 @@ Rebooting
         Use efi reset_system runtime service. If EFI is not configured or
         the EFI reset does not work, the reboot path attempts the reset using
         the keyboard controller.
+      pci
+        Use a write to the PCI config space register 0xcf9 to trigger reboot.
 
    Using warm reset will be much faster especially on big memory
    systems because the BIOS will not go through the memory check.
