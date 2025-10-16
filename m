Return-Path: <linux-tip-commits+bounces-6928-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1CFBE2969
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840B61A62972
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1C340D85;
	Thu, 16 Oct 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lB43AcA3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lCMjcjtL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A631E0ED;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608422; cv=none; b=eu9NIR5fbiBV4vYTAAvSfGj8CIQDyxboWjfPPmVJdscOD7qXRJ6+IkvJijoig7Na3T1d93HrNnby409qrjfyXst6BtMDsRkSYvPR9/nRc9zVOf9aBvE8c5uDFAF8Nx1LDM9Nm8WcRlEH+IbViYeKjrTYgDp3L3AtiXNFsQq14Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608422; c=relaxed/simple;
	bh=GuY+rFbewZQUbtMV14+0UoELwTZBWVMObWorfqF8zj4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gqZ4PmRmfQgKHuV4p20TxoBL9IFjAuNkTyXCuBJjB/ZnyEjIkg3FVOpwFSYvTpbaz7M71gdRAdU+/3fHzXspYxyWuIXDrj3N9a/2rkIMXqcy3ebbyIIdzfvu+3dS6+yg+GgTxmSFYWUZlii86QmwijYmmn46FmuohaAWmLexbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lB43AcA3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lCMjcjtL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vzHYJKydIGIbpFj3RWYXzAuwH06iu/92i/Tfe1z3ft8=;
	b=lB43AcA3C1pUR/Q9kk/w1Rwwwt2VvI2F6Gcu1oawgSDuBcn7HRmw0A4hJc/yOnbEtIyOT9
	sFuL7zVOdKqSbEoZBbj0H6Z4UlYb6nz+j8G42Ti14wxAyFMM8rMz41Rs5BP8uV4UcJv+ky
	koyLY5ooF/IHetFzbhlOCwUrBzcKP1uvMTnS4xzmqqEtZ2X15azHZBX82nYXw8k/pym5Us
	M/pK4E7CI3LJx7WRAVPcXuS4plBSRttU8g8L1TUUFL1E2nH1h3Aln0KdByvMaQ9vf/pdb7
	gGlgwwP3Vyazwx/bh3F+NLSMWjvG5IvxjOpgdxLpnTkcsEyJ1/9H5FrikBfkzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vzHYJKydIGIbpFj3RWYXzAuwH06iu/92i/Tfe1z3ft8=;
	b=lCMjcjtLJkL//5CYiOFVGfPx0WXP0bhYloYk3bWJFyiXZj7Aji4kQ48hFTNiGkaLaJN5LQ
	mn2P+z/OtK3Y+oCA==
From: "tip-bot2 for Pankaj Raghav" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] scripts/faddr2line: Use /usr/bin/env bash for portability
Cc: Pankaj Raghav <p.raghav@samsung.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060840284.709179.969176817234991592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6b4679fcbfdf6f27f8455f9c7050ab6c46c6c5e0
Gitweb:        https://git.kernel.org/tip/6b4679fcbfdf6f27f8455f9c7050ab6c46c=
6c5e0
Author:        Pankaj Raghav <p.raghav@samsung.com>
AuthorDate:    Sun, 21 Sep 2025 12:03:57 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00

scripts/faddr2line: Use /usr/bin/env bash for portability

The shebang `#!/bin/bash` assumes a fixed path for the bash interpreter.
This path does not exist on some systems, such as NixOS, causing the
script to fail.

Replace `/bin/bash` with the more portable `#!/usr/bin/env bash`.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1f364fb..7746d4a 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Translate stack dump function offsets.

