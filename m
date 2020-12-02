Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFB2CB935
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbgLBJkF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbgLBJjw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AF3C061A4A;
        Wed,  2 Dec 2020 01:38:32 -0800 (PST)
Date:   Wed, 02 Dec 2020 09:38:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FO2o4JSJouTzcjR2HhaQeYJWcTHEX9cnP8TrWpGiyXo=;
        b=3nCZEna4KnMzgZEtloOqVWA2Rvy+4j55TzNDS924+fqphTM0IDkOfRkYf1EJdqzN44MHWC
        ejZEW+pIJC5E+GgsOPvOh9xbdh3DBLRuGG10j+eZvlQtaechH8Z7dq/1BVPUOFRj6eV5/m
        faAAECk+jfrU0L0sRmBZf+dOZFWex8cCNvycnpAKKKEfv0YBrcmASnYNUD2GrzMCh9RhZH
        bkFmjh4kArbucSBP/uLDhs+7+4tA4gC/wAm5F1ujICcPsSDzZTAZShTLe53eaIpNmWR/MC
        iQniABog6tKqPucbSX0gxG4u/uPIcjltAN9t/LhczB3Tl4f6AkFnr6E/c3EGHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FO2o4JSJouTzcjR2HhaQeYJWcTHEX9cnP8TrWpGiyXo=;
        b=4fM3/6pCcvFpkDH1jknGkGXZ3S1fxzLQjS42A26gzNFJab1HdpkaupzJmehehwK0sN3ma7
        vTHZX6UaVzAiKUCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] MAINTAINERS: Add entry for common entry code
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160690190807.3364.2231043725257202372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     01fe185d95ba3cdd6629859dd911a94de8800562
Gitweb:        https://git.kernel.org/tip/01fe185d95ba3cdd6629859dd911a94de8800562
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 02 Dec 2020 01:34:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:16 +01:00

MAINTAINERS: Add entry for common entry code

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb3..a35248b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7333,6 +7333,17 @@ S:	Maintained
 F:	drivers/base/arch_topology.c
 F:	include/linux/arch_topology.h
 
+GENERIC ENTRY CODE
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Andy Lutomirski <luto@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
+F:	include/linux/entry-common.h
+F:	include/linux/entry-kvm.h
+F:	kernel/entry/
+
 GENERIC GPIO I2C DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 S:	Supported
