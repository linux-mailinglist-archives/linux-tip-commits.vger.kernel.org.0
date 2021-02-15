Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004AA31BB8A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhBOO4i (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhBOO42 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:28 -0500
Date:   Mon, 15 Feb 2021 14:55:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cvW8w/H5io8pwyE/pn6wUkcc8J5iqiSRJlxfPh2Snpc=;
        b=AADQdBRbDwaZppS/Q4i+3Gc7qNjXjDQuMInMSyYYFrGI3nsqPFf904l/n6U7zIuczARHrt
        7eQvymRk0rHQM59ISWfaLwnqVi9YEA1Wy/Jx7E8Trnw3UazxDpkwyEJLf2Dt86PJjkMCIO
        Q7MxW/BXzEE9rX/awWq5U7LMxxG4tobRq1D8SRpDWTv8n5+ivTrcIMHSJs5JJThx6Bdomd
        CAJOtU6SMiAgzCb6rd+HGpYs4i84WDMf0mw+CNbZzs597GAY5DlK2ulY+mOqF0jdFLuhQ9
        UOHIWx2hBt9ChCGFkNxRBXuzjH6CnONd7ITFBFBjjZs6m0pJdfuls+Dzw6kb7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cvW8w/H5io8pwyE/pn6wUkcc8J5iqiSRJlxfPh2Snpc=;
        b=uNUzA1eAlTfGWzFnmOHsi/cjaluGgyFfwsNqj7tZONseJT619SdaAHxclbpPz43Lw0A+wM
        xY53bgnxDtf3NDDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Document polling interfaces for Tree SRCU grace periods
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094426.20312.8335816020190823152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ee7f4a87a18cd3bb141b38e2ef0c3e53253cdf63
Gitweb:        https://git.kernel.org/tip/ee7f4a87a18cd3bb141b38e2ef0c3e53253cdf63
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 18 Nov 2020 16:01:32 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:39 -08:00

srcu: Document polling interfaces for Tree SRCU grace periods

This commit adds requirements documentation for the
get_state_synchronize_srcu(), start_poll_synchronize_srcu(), and
poll_state_synchronize_srcu() functions.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 18 +++++++++-
 1 file changed, 18 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index e8c84fc..93a189a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2600,6 +2600,24 @@ also includes ``DEFINE_SRCU()``, ``DEFINE_STATIC_SRCU()``, and
 ``init_srcu_struct()`` APIs for defining and initializing
 ``srcu_struct`` structures.
 
+More recently, the SRCU API has added polling interfaces:
+
+#. start_poll_synchronize_srcu() returns a cookie identifying
+   the completion of a future SRCU grace period and ensures
+   that this grace period will be started.
+#. poll_state_synchronize_srcu() returns ``true`` iff the
+   specified cookie corresponds to an already-completed
+   SRCU grace period.
+#. get_state_synchronize_srcu() returns a cookie just like
+   start_poll_synchronize_srcu() does, but differs in that
+   it does nothing to ensure that any future SRCU grace period
+   will be started.
+
+These functions are used to avoid unnecessary SRCU grace periods in
+certain types of buffer-cache algorithms having multi-stage age-out
+mechanisms.  The idea is that by the time the block has aged completely
+from the cache, an SRCU grace period will be very likely to have elapsed.
+
 Tasks RCU
 ~~~~~~~~~
 
