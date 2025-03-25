Return-Path: <linux-tip-commits+bounces-4451-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE9BA6EBA7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF8116C1AB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189E254AFC;
	Tue, 25 Mar 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pm1oItkP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YymQ0EtB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F551254851;
	Tue, 25 Mar 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891698; cv=none; b=LpcPIRrSi0rQOuEzu1A2UMDJdkLYVR05p/FCCp+ijcl8ABkLFUTLdzk/WsVE9kNNOutOwXPYAeWtacD/Oossj9fRNTiBzE2SpdSQduaUupz4tSJJJUc5fgIR4okNNFPFdKe/zSx3hPguJHLKretP4bTF6VJX2XwRU/mH4RtFdCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891698; c=relaxed/simple;
	bh=ed5vQXK4sXUdUF2rWxWjToCiY2g2xej6xEFkxDEHvqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mg/D6YK1nf6GkJaBIO7KdurT+BqieWqMooXM3bRNJnwGITuDyGAxKECasLEiDeOLPhdvyUwJzMl5CpzBD/RnxowhNaY6NlYbE1PUk/FknWYD/MP51oKICY1C0gY/7/iJv5GXL8ddB6dziFjjcOjowDw8UXSNgIZWdt6CwC4i0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pm1oItkP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YymQ0EtB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucPfTCEDdkRHmdhVrQy2h990w5f5Uo+d35TLt1HthVc=;
	b=pm1oItkPjIxILPFlBjjHMurjmk6QPwW1WBAkqnKXsd7YM2aPQiy+KM7epHOZNJRqFn/vtz
	6++EuOIFuprWtK7Hr1snxQt+6TNGwLGth7nKO3+ZKScUOHmbbNpccsUHHc4+FLwJp5CQSQ
	t9azEtXQsDBv4jxNOqOf0q7Tf5UefvGYYdUH6AXBKgrq+u/Vn1J/y3atjG+KYNRI07iSys
	bicaYoZKVtEp7U7RqWSiSYGsZOTIZ110STp5t+AmzYyQhpKSlbGxjWYks9HBcpjq2cy14X
	AHbRMsx+yX8Rpah1CGKx6drcIIXU4vMK05CID3c5065qFfw4oJOW8DdinWwi3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucPfTCEDdkRHmdhVrQy2h990w5f5Uo+d35TLt1HthVc=;
	b=YymQ0EtBA8a7A9CxdamYq8TSdmxY7xFkqqRyQ/qeZCzccCoywCaFPHahVkfF8qgZdqpGnK
	6MxTBrHVx3OSSuBw==
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
Message-ID: <174289169467.14745.3575414866029396374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     e3c9ccbbf5c5e1238d4ac8577559e61576b9210f
Gitweb:        https://git.kernel.org/tip/e3c9ccbbf5c5e1238d4ac8577559e61576b9210f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:08 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:29 +01:00

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
 

