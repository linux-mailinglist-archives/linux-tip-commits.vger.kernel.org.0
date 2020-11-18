Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA62B82DA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgKRRSU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgKRRST (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC39C0613D4;
        Wed, 18 Nov 2020 09:18:18 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2C//CW7cYLlEelf3H7u1THOfxg9OWXSQHgG/Gooo5w=;
        b=GUrLTJpxJVg+GP1cyE5c55xrsPMqJqw2TRGGIIR709Lo1JLOGMRYmqvfkGprodQPRWT5e4
        fw7BVJu8RzWS887plx+w1f8xX5JJkTE5vdB/n50p7J7kddTNYbgBzsUUC8IfroTmZArFCP
        dbme1kghnMv3zpEvtzNeCZU0gdwKiNQkaBV3H6ucv8DXi3d0Km3XfMFZ8Cgd+xKnBvU/GX
        3iOdYUq0BFQDInUAtjWEM5AhESih50a2VFUgercouODsRl5EpTAvnvSFe8TBMd8yY5otcB
        dRCOsGPuo31pKG86hGZBQvjMPxALZJbsZsfe2Hn3ME17LZnf7rk47YbA97d0DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2C//CW7cYLlEelf3H7u1THOfxg9OWXSQHgG/Gooo5w=;
        b=j5kH8L8eCOxls7cov7Orsrn9aFppfAIEtXXjhQ6+KcyB9BwIKA652thy6pWeHfEfTr1xPe
        BZprZJ6BFPitw8BA==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Update MAINTAINERS
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-25-jarkko@kernel.org>
References: <20201112220135.165028-25-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571989611.11244.17085791285971541095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     bc4bac2ecef0e47fd5c02f9c6f9585fd477f9beb
Gitweb:        https://git.kernel.org/tip/bc4bac2ecef0e47fd5c02f9c6f9585fd477f9beb
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:16:28 +01:00

x86/sgx: Update MAINTAINERS

Add the maintainer information for the SGX subsystem.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-25-jarkko@kernel.org
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e451dcc..44c240c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9126,6 +9126,19 @@ F:	Documentation/x86/intel_txt.rst
 F:	arch/x86/kernel/tboot.c
 F:	include/linux/tboot.h
 
+INTEL SGX
+M:	Jarkko Sakkinen <jarkko@kernel.org>
+L:	linux-sgx@vger.kernel.org
+S:	Supported
+Q:	https://patchwork.kernel.org/project/intel-sgx/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-sgx.git
+F:	Documentation/x86/sgx.rst
+F:	arch/x86/entry/vdso/vsgx.S
+F:	arch/x86/include/uapi/asm/sgx.h
+F:	arch/x86/kernel/cpu/sgx/*
+F:	tools/testing/selftests/sgx/*
+K:	\bSGX_
+
 INTERCONNECT API
 M:	Georgi Djakov <georgi.djakov@linaro.org>
 L:	linux-pm@vger.kernel.org
