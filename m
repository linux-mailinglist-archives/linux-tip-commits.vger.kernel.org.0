Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D254B3B8442
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhF3Nx5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:53:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhF3NwE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:52:04 -0400
Date:   Wed, 30 Jun 2021 13:48:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ShDh6ieyzUFBqSQ8wetZp4jRCJccY7ABYkmLjDjbaOM=;
        b=ItdItQYBs9D8UKHer9IwmuVfPPBCyyZh9q2VupK25zOnLc8jInfitQRSGKf++VDpW1TWUz
        3p6h/4xSM8urGkyTdTWsp/nKCQi1mt6PFh5HiT26LWDTaYDnjYWDDQzr7z+SINOjrwj2vh
        nowo5IqftEmD99elS+cNtzGgDr5N9sr8IhHBmLSpZjLaLZx3RHV0kByNuy8i5yLujzV13I
        wppIxCPNPMZ2RmNXPXwx4WhdNi3DpX0rdmFWjnjlwBsFCBCgLj8qJDOvcvvahTiRQvcEk2
        u57DHkoEAxGq3aTg+P3H5XWklN8OtDLbBFpT2LIbRZaLEQlNEohHxij/UbKl/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ShDh6ieyzUFBqSQ8wetZp4jRCJccY7ABYkmLjDjbaOM=;
        b=k1EHP92CohrxlvApzuKhgWrola4CWNM7SWPCF5f3yzQUVEQaJ/wzlrAZdNcST01WPXcAPj
        ioKaOs473VKDhGBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kcsan: Add pointer to access-marking.txt to
 data_race() bullet
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506090131.395.14968745337974466077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     ea0484644e5b8486c8335f677fc1e2a4a5d76d3f
Gitweb:        https://git.kernel.org/tip/ea0484644e5b8486c8335f677fc1e2a4a5d76d3f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 04 Mar 2021 16:04:09 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:58:14 -07:00

kcsan: Add pointer to access-marking.txt to data_race() bullet

This commit references tools/memory-model/Documentation/access-marking.txt
in the bullet introducing data_race().  The access-marking.txt file
gives advice on when data_race() should and should not be used.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index d85ce23..8089466 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -106,7 +106,9 @@ the below options are available:
 
 * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
   any data races due to accesses in ``expr`` should be ignored and resulting
-  behaviour when encountering a data race is deemed safe.
+  behaviour when encountering a data race is deemed safe.  Please see
+  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
+  tree for more information.
 
 * Disabling data race detection for entire functions can be accomplished by
   using the function attribute ``__no_kcsan``::
