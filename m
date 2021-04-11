Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1E535B4BE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbhDKNoG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Date:   Sun, 11 Apr 2021 13:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Uzq1iF1W7bcqPys37Zl0EEnRcfz53iwGSRhT4r92kc4=;
        b=T/NeqzKG7FjoKtq4qHfnMq11WWBgtJalEZa6SFEGmvGTGp8Pg/RYdfzgMW1JKIDjlga1VY
        EGBHFXlHDgJF6SvBNlG9oY5gg0p+E180mwTDyHbGITxImcD+9hNWybna83gDHlteWB4dBG
        TOQ5Y7Dm9whmOBI2IbU68i23LAo3jJSaAE0WiVFMTzX5NeP9myUmaFy12AAyNVjeZuIEAP
        e204ABJnrf+9X4nF8a9uBCQBhB/v7oHNHoAccxsptnW7tgiQ8IY17BFxGDkN+q5SAajBce
        syz0s3kKGiF7WSc9yP9xxGv3zabchVGms8i84LuDYn8rCROuA78Q8eMt8O5m4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Uzq1iF1W7bcqPys37Zl0EEnRcfz53iwGSRhT4r92kc4=;
        b=RLIosOWiusPZhMDdIaJqzSCY2jrrafj6CTqxyea8SEO6ET8YaWTSiMnANx+4WVDetHJ1zr
        DkRTslExAo9w1bAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Remove no-mpstat error message
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860311.29796.4824484923453056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     996a042e0a0684b7a666b9d745784623a3531b27
Gitweb:        https://git.kernel.org/tip/996a042e0a0684b7a666b9d745784623a3531b27
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Feb 2021 20:17:44 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:17 -07:00

torture: Remove no-mpstat error message

The cpus2use.sh script complains if the mpstat command is not available,
and instead uses all available CPUs.  Unfortunately, this complaint
goes to stdout, where it confuses invokers who expect a single number.
This commit removes this error message in order to avoid this confusion.
The tendency of late has been to give rcutorture a full system, so this
should not cause issues.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/cpus2use.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/cpus2use.sh b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
index 1dbfb62..6bb9930 100755
--- a/tools/testing/selftests/rcutorture/bin/cpus2use.sh
+++ b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
@@ -21,7 +21,6 @@ then
 		awk -v ncpus=$ncpus '{ print ncpus * ($7 + $NF) / 100 }'`
 else
 	# No mpstat command, so use all available CPUs.
-	echo The mpstat command is not available, so greedily using all CPUs.
 	idlecpus=$ncpus
 fi
 awk -v ncpus=$ncpus -v idlecpus=$idlecpus < /dev/null '
