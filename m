Return-Path: <linux-tip-commits+bounces-4546-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D394A70C95
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8553B589B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462326A091;
	Tue, 25 Mar 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ygZbZihJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRnV05vh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D1269CFA;
	Tue, 25 Mar 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940600; cv=none; b=gg8/HB7jL0FuDyHjUqhVm81M2nZ1qMqctzRLJdK7DTHrmnPfibJiccmOhamSu/9arwkE2mBxPnxa7zl3WjQUMGh4lqlSURw6B9zfkUl93VQd8s78h/2SNt8JNBizt8iCSrgpaX8od/q/SorVKJmXR8F1TN4I+2ePbdPV2DSlnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940600; c=relaxed/simple;
	bh=JwJ0WIE2WtO9Jcdfs3Y1gIAxEUWkh34k+gPMyLlQDYU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OVt/vqOCqInpkqQT0K4q/317vAJblMFRiqCyd98pMYELTwEftnLHJL1kJ2vgKBHEDkaEVbSHrWUyNd3tlaw7NIEq+uy+6HCk9lrT4ugVJ8Y25qLDB9g4b0mlmWLNuGZJsgHTWQ0aPA2QqYLkpaXEoWUegsS3hrqlaJTZzh+2y9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ygZbZihJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRnV05vh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 22:09:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742940597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TBZEd96ReYIi/JnRs1+n7VL/zUVsYi+Vc6SE4hSr1g=;
	b=ygZbZihJ5C5gv5tKWIA1lqcnXC2S0IvJcbzsyyPj2UWjJ7+JWbDlgSz+5SuNlidsaeu+fW
	oO68Zmrbnwya7fpRLM0/K4fv3cuJHgsCHJu7caRJRML1t25TBgaVmWr9G5Dv+x198nKunR
	f9e7BXH4qdHbf2yLRQ6KTEz9BhGE7pQfg+jY5S4ufaGnpRexXzHP34w5/c4+N3YFdgWdAq
	vUvJ57iC6Ij2i7czHCLOk3H8iqi2iGHWZEIJlEysKthsLOAO3vZskdQD5zPC0zbvBqUCA6
	9a1GLcSJLZRR/XHRBBz2+Ra+LF4w0mBRaXObfFys5vcpN8mXlAbuLzROQ+S0hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742940597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TBZEd96ReYIi/JnRs1+n7VL/zUVsYi+Vc6SE4hSr1g=;
	b=zRnV05vhqDsaiuucMHffH3HkvsHnROT6qXlV+5STfwQmeGl94mYCxzJ/pMc+FblAjGhmGw
	YA+CpjGA1XALsMAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, Input: cyapa - Remove undefined
 behavior in cyapa_update_fw_store()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <73ae0bb3c656735890d914b74c9d6bb40c25d3cd.1742852847.git.jpoimboe@kernel.org>
References:
 <73ae0bb3c656735890d914b74c9d6bb40c25d3cd.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174294059651.14745.3925612014875238987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     7501153750b47416c9891038330359fad0205839
Gitweb:        https://git.kernel.org/tip/7501153750b47416c9891038330359fad0205839
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:08 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 23:00:15 +01:00

objtool, Input: cyapa - Remove undefined behavior in cyapa_update_fw_store()

In cyapa_update_fw_store(), if 'count' is zero, the write to
fw_name[count-1] underflows the array.

Presumably that's not possible in normal operation, as its caller
sysfs_kf_write() already checks for zero.  Regardless it's a good idea
to check for the error explicitly and avoid undefined behavior.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: .text.cyapa_update_fw_store: unexpected end of section

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/73ae0bb3c656735890d914b74c9d6bb40c25d3cd.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/
---
 drivers/input/mouse/cyapa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 2f2d925..00c87c0 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1080,8 +1080,8 @@ static ssize_t cyapa_update_fw_store(struct device *dev,
 	char fw_name[NAME_MAX];
 	int ret, error;
 
-	if (count >= NAME_MAX) {
-		dev_err(dev, "File name too long\n");
+	if (!count || count >= NAME_MAX) {
+		dev_err(dev, "Bad file name size\n");
 		return -EINVAL;
 	}
 

