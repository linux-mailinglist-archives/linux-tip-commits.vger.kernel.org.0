Return-Path: <linux-tip-commits+bounces-1391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5C909031
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Jun 2024 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A70B4B2B6FC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Jun 2024 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658621922F8;
	Fri, 14 Jun 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tP8ukyDI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTu45PSU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10C181CE9;
	Fri, 14 Jun 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382289; cv=none; b=LHh14AIxGaPn3C9VKmBpOYDABfRboL5esWMqOo9DQjhZ/9BKMe3TmRdS/XEAFIqcfPYbvFTyWrMcubNzG3ASmeQFym7jacafNUfcUJcshQ0y5S/e52sat9cLBfUlZoOG2zHlMvYwoLFGAXoGHeWtikd539kQZC8QxDYTtslKpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382289; c=relaxed/simple;
	bh=o+ijjZOZoIvyLHRcTd8AOdZXd9lOhdvQG2/WHdoECJg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SnqePOQbTJNZagPugn2LTCWhyHhvtbdnkUzhhOWskiVn+kvO46h5IgYOWq638DDZD/OJWpy+oCOm3yB6quAfKOVfddPTBuVUvnmvbzI2SsSG/zcMXWiQKHTFuz9Pykm03+ZFqN7bCP2lcHK1t1HhfFJyP4z8PwktFBVLqZsaUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tP8ukyDI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTu45PSU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Jun 2024 16:24:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718382286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIk7R4HvbRe8pW95wqhJ7pleR+j0c/vPQE3pE+CqFPg=;
	b=tP8ukyDI4dIuhLBrnlnUj7Zr11V3/8Xjd3Nry4sMqPyhlHqQVFiyfTKKROTj6f4y8EoRt3
	eFrZbzn/Z6IxpRJOe3fx0z0/DzXMeTNLRyt7exCJcfkjW4j8gE0cbzDa83uBo/Ujv8aFRP
	yK2+EgQffeCMXn9xB8BcS5SioIMcwftFFhFy7MHjSJpo7PG3uxG9zcx8imCdX31KG3wCR+
	NTsJwX0gTKOhvXRwQTNxMRyPFp6z/ufBuvmVmFle4onmpcBGa4B7uRSJTriFMfR5mZQ9ai
	8fGR4lAaKuxGYkh5Owl2GVbHqDPy2AhWkhBvq8okKiSujVTCIYF0i/uFeOyH0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718382286;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIk7R4HvbRe8pW95wqhJ7pleR+j0c/vPQE3pE+CqFPg=;
	b=XTu45PSUrPJ7uANSLqThGIbfvZPlzRdBvgUyERSJRCBqtrZ469viHNMFKe3YcZbk+bHkVr
	4d5FGn5HECyQg0AQ==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/boot: Remove unused function __fortify_panic()
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613110837.300273-1-nik.borisov@suse.com>
References: <20240613110837.300273-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171838228550.10875.5357369039737552236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     71315037cb7d40cdb2f4fbefad31927f6e6caba5
Gitweb:        https://git.kernel.org/tip/71315037cb7d40cdb2f4fbefad31927f6e6caba5
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Thu, 13 Jun 2024 14:08:37 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Jun 2024 18:08:45 +02:00

x86/boot: Remove unused function __fortify_panic()

That function is only used when the kernel is compiled with FORTIFY_SOURCE and
when the kernel proper string.h header is used. The decompressor code doesn't
use the kernel proper header but has local copy which doesn't contain any
fortified implementations of the various string functions. As such
__fortify_panic() can never be called from the decompressor so remove it.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613110837.300273-1-nik.borisov@suse.com
---
 arch/x86/boot/compressed/misc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a2..9444543 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -531,8 +531,3 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 
 	return output + entry_offset;
 }
-
-void __fortify_panic(const u8 reason, size_t avail, size_t size)
-{
-	error("detected buffer overflow");
-}

