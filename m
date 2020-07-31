Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732D623426A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbgGaJWr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732222AbgGaJWq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38358C061574;
        Fri, 31 Jul 2020 02:22:46 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T7ukGN4bM+gflCLO43W24GiEXTL1gig4f058wloVrgQ=;
        b=C4fVIQ4qqcQ7KjisFmH7KE85z3arTWgtadWl4qSek48cIqKPuRT2rciEPDz7n9meeVDtEE
        /dIaW1jICKxs5+rm5LrMTkKxtMR8lfnO9jlMYY54CYZXmZxbVVM2XrNGi5YM22HJ36Jqbf
        OI0+N3pMk/kttENoGTGMqprVtPEXFT0obRjJpc9UNoC/ZeAArmY/JDeiqPZySTD9BXhGvr
        QmCAC2N517acpiYf0Oqb1vwdbsuPRlvsu0Drmdh9SyRozY3MXYNgbx4DLofU1EW/sNVym0
        O2Zi6yyM009iaBfEieJYfhO8LqC03uBqniUBL6vdPSRVtPO0tNRrEEu6K8XDeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=T7ukGN4bM+gflCLO43W24GiEXTL1gig4f058wloVrgQ=;
        b=9dgheEA8S9H9LZMLCa9UU2nStCggbDAd7FXbthSmcdBUgQQNmQ/qx4ZnNPurMhz4wkizD/
        rd3YYQR0d8AFWvDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add --allcpus argument to the kvm.sh script
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736410.4006.3706383349129713648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a3ba4972f2ef8408dcc8a2a3d433621d6c990594
Gitweb:        https://git.kernel.org/tip/a3ba4972f2ef8408dcc8a2a3d433621d6c990594
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 04 May 2020 16:41:53 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Add --allcpus argument to the kvm.sh script

Leaving off the kvm.sh script's --cpus argument results in the script
testing the scenarios sequentially, which can be quite slow.  However,
having to specify the actual number of CPUs can be error-prone.
This commit therefore adds a --allcpus argument that causes kvm.sh to
use all available CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c279cf9..7dbce7a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -73,6 +73,10 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--allcpus)
+		cpus=$TORTURE_ALLOTED_CPUS
+		max_cpus=$TORTURE_ALLOTED_CPUS
+		;;
 	--bootargs|--bootarg)
 		checkarg --bootargs "(list of kernel boot arguments)" "$#" "$2" '.*' '^--'
 		TORTURE_BOOTARGS="$2"
