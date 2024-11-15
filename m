Return-Path: <linux-tip-commits+bounces-2866-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA29CDD80
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2024 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B71BB26B6E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2024 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4521B86F6;
	Fri, 15 Nov 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4aK26Oz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5vGnM1xU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52371B6D1D;
	Fri, 15 Nov 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670149; cv=none; b=s6MCj3B0oFIQMpL46pTytr6vPDAo5BY4zjglOq79T0oH7dryEjDLyPUWEC7Hrz2VctUIMtrzwkDpX0pIzN5YrslFNHNrNpQW43DbQLqMM3x8nOn9EtQ27HeqEeRf1XSxlIZIjJhwqcQoYrKBeJ+naVrvlPkqn5/5xkf/DN1rBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670149; c=relaxed/simple;
	bh=cvgDxbI4ErhonkpbnkP5oqXKlGDRju5PPuzzh+mWFBk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jmcI/6+ziU6JXpbEj3ezFcZ8hdR4aGfEr1RLxT1/4utICc9f0WOLnk72WOEh1NfGX87ov7hh0JRuy9rvI5sxGMXef49DXE+aiaEgGBGO6uDID3mgsMWSZKnf4N1hIzSlXcJhIWCIYu4lc7NcmR0AFdQcS8u5HANCRQ6XwQoHefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4aK26Oz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5vGnM1xU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Nov 2024 11:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731670139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kBY8Gu1YZckM2dkmLkWwG2P/p7oeKh5bP1HV4wU9b0=;
	b=s4aK26OzyrD973JwDFl0QUNXf4tzbgQuK6AsrTZvLNCMb0mlwvpOGdqJhjEQlADQ7OxjK5
	s1ZvnMtX1GBPuGfQf0EKIaL3Fc8o26kgR6YGioyuflffBmjSh4HP8nqxMjAUJVaJGuf62r
	5aLFeGWdtvFeeykq4B9aMocDp+IgO9RJHDiTj0zOchiBNDGmQMcvCapk3cU8uR8aXbAfzi
	KlzWdfuIywiwk4tmUxD013yeJ+YTluVRm1v8hI5wPxZHYsaPqxJfjd3fxMZRepuCW/Qr4g
	DOuakiEpofpV1b0CfwE8fiAf9uSgBp7Egg18lTG7gezh0vy0OvTR8izORP7kBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731670139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kBY8Gu1YZckM2dkmLkWwG2P/p7oeKh5bP1HV4wU9b0=;
	b=5vGnM1xUJk/cXYltgie/bP+cVx5OTxcI0azeiq6V7a13mwIlXyp16TsjFC2P7MNOwm1uKe
	v2aVVuUor67gEKBQ==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/ioremap: Introduce helper to check if physical
 address is in setup_data
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115012131.509226-2-bhe@redhat.com>
References: <20241115012131.509226-2-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173167013884.412.2613996555717892985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     e1d30a1f6c2196de359ac7c2726ba07fcd389cc4
Gitweb:        https://git.kernel.org/tip/e1d30a1f6c2196de359ac7c2726ba07fcd389cc4
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Fri, 15 Nov 2024 09:21:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2024 12:03:36 +01:00

x86/ioremap: Introduce helper to check if physical address is in setup_data

Functions memremap_is_setup_data() and early_memremap_is_setup_data()
share completely the same process and handling, except of the
different memremap/unmap invocations.

Add helper __memremap_is_setup_data() to extract the common part,
parameter 'early' is used to decide what kind of memremap/unmap
APIs are called.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241115012131.509226-2-bhe@redhat.com
---
 arch/x86/mm/ioremap.c | 81 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163..5ef6182 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -628,6 +628,87 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
 	return false;
 }
 
+#define SD_SIZE sizeof(struct setup_data)
+/*
+ * Examine the physical address to determine if it is boot data by checking
+ * it against the boot params setup_data chain.
+ */
+static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
+						bool early)
+{
+	struct setup_indirect *indirect;
+	struct setup_data *data;
+	u64 paddr, paddr_next;
+
+	paddr = boot_params.hdr.setup_data;
+	while (paddr) {
+		unsigned int len, size;
+
+		if (phys_addr == paddr)
+			return true;
+
+		if (early)
+			data = early_memremap_decrypted(paddr, SD_SIZE);
+		else
+			data = memremap(paddr, SD_SIZE,
+					MEMREMAP_WB | MEMREMAP_DEC);
+		if (!data) {
+			pr_warn("failed to memremap setup_data entry\n");
+			return false;
+		}
+
+		size = SD_SIZE;
+
+		paddr_next = data->next;
+		len = data->len;
+
+		if ((phys_addr > paddr) &&
+		    (phys_addr < (paddr + SD_SIZE + len))) {
+			if (early)
+				early_memunmap(data, SD_SIZE);
+			else
+				memunmap(data);
+			return true;
+		}
+
+		if (data->type == SETUP_INDIRECT) {
+			size += len;
+			if (early) {
+				early_memunmap(data, SD_SIZE);
+				data = early_memremap_decrypted(paddr, size);
+			} else {
+				memunmap(data);
+				data = memremap(paddr, size,
+						MEMREMAP_WB | MEMREMAP_DEC);
+			}
+			if (!data) {
+				pr_warn("failed to memremap indirect setup_data\n");
+				return false;
+			}
+
+			indirect = (struct setup_indirect *)data->data;
+
+			if (indirect->type != SETUP_INDIRECT) {
+				paddr = indirect->addr;
+				len = indirect->len;
+			}
+		}
+
+		if (early)
+			early_memunmap(data, size);
+		else
+			memunmap(data);
+
+		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
+			return true;
+
+		paddr = paddr_next;
+	}
+
+	return false;
+}
+#undef SD_SIZE
+
 /*
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.

