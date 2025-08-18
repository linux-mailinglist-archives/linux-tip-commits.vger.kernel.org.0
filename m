Return-Path: <linux-tip-commits+bounces-6271-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18279B29EFC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF6F5E241E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B6F31578C;
	Mon, 18 Aug 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wko1+fmV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qPGIavAi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786D258EE1;
	Mon, 18 Aug 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512553; cv=none; b=AQqtTPxJmp7l34bU1NLchuFYTh8cSMQVanCLyBR4vVQxY5Gzd6Vze8NoKcwkKR0EjyvpNrvVDR4TnfvIR7j//UYQjbXnrKHKKAMA2HickYbVjYgYWkZEw4mJgPHEQkEeADgkUzOo3EMhIxQvet3GxxoAHvwUxyBXTqD7cxmSnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512553; c=relaxed/simple;
	bh=+VXOHREnmgKH+II4c3BorPv0ghuqrBwmlgEbBzrleww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=luHeU5a44H/XdHTbpCcqIH6m+WxD5dZ8cib8Hod4qbGvFp1ozPRzZDimRTmAQfwNtv8KO2gRTWmC6P2rnGPx53Ul6KhynDhFVnJdItKDYFviRGtO0PNfAUqwFwBwFPigXSTkcv5ahjv73B47tWQYanM5qf7psD/5h6MWcPsMgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wko1+fmV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qPGIavAi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512550;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKgd0vRuJRsrLDX+wWrOLrISQp4VhAa8Q1tfmClFKJk=;
	b=Wko1+fmVy52TAGeXlXpXamWnXBRJciF0qmYZD+0OE4IizrLtG0J0q7p3cLCUQ8pdKy9YU7
	QG+sqLZiRgF8D8U/o84P7lyxXwovpPdsX3AU0zA5NMrXUBv6oR1SUcUDRT3rCEG1Az+WPT
	fXrj7d+Vw4djIkg+Q/cQfOOjNJe6eYDD+2Ydh25pqkNfePQosAnNgPrep0/eZUBkc/maN6
	1PFziGtlMOLtgrt4K5nZLCUuMpMMK09c842h4EGmAqmhuskj/eCYMnyo+LUKHeN9unVBXz
	AA4sm0V12AlbEhJnZgXLfVUJuQ/qRS7+F5i1hXGkmzc/An1UGGiO6FhhZjyTgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512550;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKgd0vRuJRsrLDX+wWrOLrISQp4VhAa8Q1tfmClFKJk=;
	b=qPGIavAi4A+62LFHhARSRD/sRRURoLCQZaPfBzbQqkNIGUycjzJ1KmbKmldxnUsH4Yfktv
	kr+UQvrAZDiXpcBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Remove redundant aux_unlock label
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104019.131293512@infradead.org>
References: <20250812104019.131293512@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551254952.1420.16615429286163158578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     41b80e1d74bdef5e48ea63d186244b9f6f82a4da
Gitweb:        https://git.kernel.org/tip/41b80e1d74bdef5e48ea63d186244b9f6f8=
2a4da
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:13:00 +02:00

perf: Remove redundant aux_unlock label

unlock and aux_unlock are now identical, remove the aux_unlock one.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104019.131293512@infradead.org
---
 kernel/events/core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dfe09b0..89fb069 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7098,7 +7098,7 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
=20
 		rb =3D event->rb;
 		if (!rb)
-			goto aux_unlock;
+			goto unlock;
=20
 		aux_mutex =3D &rb->aux_mutex;
 		mutex_lock(aux_mutex);
@@ -7107,27 +7107,27 @@ static int perf_mmap(struct file *file, struct vm_are=
a_struct *vma)
 		aux_size =3D READ_ONCE(rb->user_page->aux_size);
=20
 		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
-			goto aux_unlock;
+			goto unlock;
=20
 		if (aux_offset !=3D vma->vm_pgoff << PAGE_SHIFT)
-			goto aux_unlock;
+			goto unlock;
=20
 		/* already mapped with a different offset */
 		if (rb_has_aux(rb) && rb->aux_pgoff !=3D vma->vm_pgoff)
-			goto aux_unlock;
+			goto unlock;
=20
 		if (aux_size !=3D nr_pages * PAGE_SIZE)
-			goto aux_unlock;
+			goto unlock;
=20
 		/* already mapped with a different size */
 		if (rb_has_aux(rb) && rb->aux_nr_pages !=3D nr_pages)
-			goto aux_unlock;
+			goto unlock;
=20
 		if (!is_power_of_2(nr_pages))
-			goto aux_unlock;
+			goto unlock;
=20
 		if (!atomic_inc_not_zero(&rb->mmap_count))
-			goto aux_unlock;
+			goto unlock;
=20
 		if (rb_has_aux(rb)) {
 			atomic_inc(&rb->aux_mmap_count);
@@ -7161,7 +7161,6 @@ aux_success:
 	}
=20
 unlock:
-aux_unlock:
 	if (aux_mutex)
 		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);

