Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE114949F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgAYKmt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:42:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbgAYKmt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItl-0008KB-Bm; Sat, 25 Jan 2020 11:42:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CF71C1C1A73;
        Sat, 25 Jan 2020 11:42:39 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:39 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] .mailmap: Add entries for old paulmck@kernel.org addresses
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994895966.396.2331102015410337763.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     05d35961c20b8919bb94df6f626f306553758d59
Gitweb:        https://git.kernel.org/tip/05d35961c20b8919bb94df6f626f306553758d59
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 Nov 2019 15:35:26 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 24 Jan 2020 10:33:52 -08:00

.mailmap: Add entries for old paulmck@kernel.org addresses

[ paulmck: Apply Florian Fainelli feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index c24773d..39efbe9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -207,6 +207,10 @@ Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paul.mckenney@linaro.org>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
