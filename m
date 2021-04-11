Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E785B35B4CA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhDKNoJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Date:   Sun, 11 Apr 2021 13:43:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IRWhUAUnDG0eeTgFZ7MgQrR9iErNe70DkSu0YO3rtKg=;
        b=XLS7vt/2D4DVvY6bfGYy4gn6igTTK/b0eW5BJNADAaqp/0ovxnjCxUG+t17LjjBoGA7xUq
        6Wpmz+lPKvNhdw6R9BszGfwxUgtgjiMVcUcvcdK7PTA+s5/mccp9ajzfskQdlv3nK75NS3
        00yAq9WTv4lbAou9r+8kLzd5xUD5R/xqFyalrKVH3lESfoK1j9TykFAxAtFYzw9G0AOpuz
        eUSF72MqB1WZl/jFJh0EPmXOOOX3LYZMoMV6qsLt3+wLOzXQtu7wQLp4deUDvb9XeJHAyM
        nSOXXy/kZm7fcJLhtIDjqkdD2Imqs2BXt8ys8RvbJWKvrsE57Y6efzG01jtm1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IRWhUAUnDG0eeTgFZ7MgQrR9iErNe70DkSu0YO3rtKg=;
        b=iDCkqtwFcS1hurproF40/A+aMi2R78sX3tMz3dmXjRxaO+HpOapfuA4pSe9BYd4qC4uMUN
        HrjhNcrwmy2XPCCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make upper-case-only no-dot no-slash
 scenario names official
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860223.29796.10884015581903194955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e633e63aa907feff98c654c1919101f3d53ebd5b
Gitweb:        https://git.kernel.org/tip/e633e63aa907feff98c654c1919101f3d53ebd5b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Feb 2021 07:15:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:18 -07:00

torture: Make upper-case-only no-dot no-slash scenario names official

This commit enforces the defacto restriction on scenario names, which is
that they contain neither "/", ".", nor lowercase alphabetic characters.
This restriction avoids collisions between scenario names and the torture
scripting's files and directories.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index efcbd12..03364f4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -104,7 +104,7 @@ do
 		TORTURE_BUILDONLY=1
 		;;
 	--configs|--config)
-		checkarg --configs "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
+		checkarg --configs "(list of config files)" "$#" "$2" '^[^/.a-z]\+$' '^--'
 		configs="$configs $2"
 		shift
 		;;
