Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605092882B4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgJIGjH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbgJIGfS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:18 -0400
Date:   Fri, 09 Oct 2020 06:35:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/1RjQT4j/fjyt/Tb+ofdNNSXuqFqY165LYceLcclm4E=;
        b=SBPMb24Oydwsg2RBupvmkBhvHK04NKFf2jIMdzEatPoWsq6QguEdiYc2P9UZNGhd6Xkjm1
        9u+hBBPfh0XMseTIesq7SuFvqI5lStQ3pS4sFqFxVJeS1uMvI+21CYRRarw+5+rhjBfz0N
        LOvqtznIx+SnI+EJ3oD3X/rqkXfNVmVja7+rDpz7yyrQkFidO9dZbF7Ptx5sz+go/E1Kqr
        IgydrXVnG1b5A93lbOrE7MGJi6JLaGye78xdOpdpEDawmYygOrdZMpcR68j/Hu+jFE1/VR
        8W0h4KT0hCXDS9BjjmEDnb6yvIg0kYeR3K2e2lW/RWKt1FFMQzCpGlhqfGxm5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/1RjQT4j/fjyt/Tb+ofdNNSXuqFqY165LYceLcclm4E=;
        b=DwOikueuuA50wtxHVPwHLba8YWWSHj7+bxDxcts6XRLq4cUQfGxpL8Ht+AyvlTzzQ2Spkv
        bEnzXgQQ4HbgqxAw==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: document --allcpus argument added to the
 kvm.sh script
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531589.7002.3983219765542125573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     fbb9f8531a0d6693189783d295114db4c30624ca
Gitweb:        https://git.kernel.org/tip/fbb9f8531a0d6693189783d295114db4c30624ca
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Thu, 02 Jul 2020 15:59:05 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:31 -07:00

torture: document --allcpus argument added to the kvm.sh script

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index e655983..0a08463 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -46,6 +46,7 @@ jitter="-1"
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
+	echo "       --allcpus"
 	echo "       --bootargs kernel-boot-arguments"
 	echo "       --bootimage relative-path-to-kernel-boot-image"
 	echo "       --buildonly"
