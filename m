Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA774298C30
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773934AbgJZLoT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 07:44:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771217AbgJZLoT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 07:44:19 -0400
Date:   Mon, 26 Oct 2020 11:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603712656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9r0tmz7BJI34Wwq31VAwC2xPjtcvmpNA56buUqVOcOo=;
        b=W3GpE84T1A6n5ckz4wCAIA6dvRt6z2uGrwlkh4yuCr2m939OO3FyVB3al0Fmaooi+/fgyC
        drEPFo5HB+XHQFED7jBejDjh2vbtcEhhDYzMyXZ7c14aTvPnHg0O0uKtRJ1St1wUJhmxF0
        22W197FfXS96SiFwzDUUrfqHeHE4o3j3kM4Rz69GU3wAwDFXx7S3nsaXtonh0Dx4WO0/o+
        d676+9DRLbleXzt0mJjvZiAD8yt9hIiOHWYuNHmyYWifJMIWIf2HOiXVZeJz9ZjPQARGbP
        vY7IlfRj6aY1vMJfOAhhaMeu/Dypqmh53Tmqldik43Cxd6xuMQHQgOOq3e4DGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603712656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9r0tmz7BJI34Wwq31VAwC2xPjtcvmpNA56buUqVOcOo=;
        b=nTtYFSVkw3cPyD3wYjlew0VSNoM9guvZ/u9wqrVaVyd/kMMclvcWOOYoc3Al888rnMlie2
        4orKAm9Qnz3ihODA==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] MAINTAINERS: Cleanup SGI-related entries
Cc:     Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201019203533.GA1203217@swahl-home.5wahls.com>
References: <20201019203533.GA1203217@swahl-home.5wahls.com>
MIME-Version: 1.0
Message-ID: <160371265538.397.7808863211578338393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     632211cdd6ad0efeef32c53ac731901b4bed3b94
Gitweb:        https://git.kernel.org/tip/632211cdd6ad0efeef32c53ac731901b4bed3b94
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Mon, 19 Oct 2020 15:35:33 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 26 Oct 2020 12:39:05 +01:00

MAINTAINERS: Cleanup SGI-related entries

UV platforms are the only ones which currently use the XP/XPC/XPNET
driver, so it seems fair HPE should take some responsibility as
maintainers of it; so add Mike Travis and Steve Wahl. Cliff Whickman's
email address is no longer valid, so remove it. Robin Holt was contacted
and wishes to remain as a maintainer.

Update Dimitri Sivanich's email address for the SGI GRU driver.

Add Mike Travis to HPE Superdome Flex (UV) platform.

 [ bp: Massage commit message. ]

Acked-by: Robin Holt <robinmholt@gmail.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201019203533.GA1203217@swahl-home.5wahls.com
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..e706e14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15833,13 +15833,14 @@ F:	include/linux/sfp.h
 K:	phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
 
 SGI GRU DRIVER
-M:	Dimitri Sivanich <sivanich@sgi.com>
+M:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
 S:	Maintained
 F:	drivers/misc/sgi-gru/
 
 SGI XP/XPC/XPNET DRIVER
-M:	Cliff Whickman <cpw@sgi.com>
 M:	Robin Holt <robinmholt@gmail.com>
+M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Mike Travis <mike.travis@hpe.com>
 S:	Maintained
 F:	drivers/misc/sgi-xp/
 
@@ -19085,6 +19086,7 @@ F:	arch/x86/platform
 
 X86 PLATFORM UV HPE SUPERDOME FLEX
 M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Mike Travis <mike.travis@hpe.com>
 R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
 R:	Russ Anderson <russ.anderson@hpe.com>
 S:	Supported
