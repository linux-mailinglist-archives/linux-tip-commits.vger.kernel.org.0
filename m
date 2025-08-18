Return-Path: <linux-tip-commits+bounces-6268-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99364B29F12
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D37017E500
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573C932144E;
	Mon, 18 Aug 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5l2rjqL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKdxSWvU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C730E82E;
	Mon, 18 Aug 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512550; cv=none; b=AMxKjMt3UQVEmJ0XC5LCHhSfqW0BZKVqX+B+n3fx9RuasTMkHyrhmoT08PU4Iwo7TpQXKJCqDJrW64oxknjNOYHkdIoU9JYovyfA4zPiAzOOxl5pAIKcHpM13z4DYPvTkcaXzIrC9J0haaLTqq7epgKa2YY63Ib8DG2jqwsLCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512550; c=relaxed/simple;
	bh=DMAveFfvUN6deTQzFhsPJqtjPDXtZLWY51NmnFXoYuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U3Q4+s2N7qRKDVy/1FRgvWwk0JwoMW4ZxJmEO1rFUKmrINjiF2JLbziV+ukam1ejp17fMTWPxqj7BzKuQvzFI/qu5QIZ0gxNjfR4EVptovE6C3dWqhQ+rXvVlCMkHdPIL4gXbZ4fMzN4UtNxRxVXIvoJZy9kzoe+OKObZjBGhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5l2rjqL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKdxSWvU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9SjC7lUH+GkLlvOrY9vqVnXDja7uDl2cbhH+lMcz+k=;
	b=J5l2rjqLueCbqO9IiJCKWFJ9uk5fABSlh6HINqrY+uTBs2Zbpa2GbLhVgWMwMYTl7o2oGG
	yqhIx2FlQvwcRqpuKRWBty936XfEwG7HEx/68gCjGLpWqfYmVnaJccMGEBEESLHL+JjW94
	+C0EroXtuNbONHL0hHDuTg0HiatNHhKVa2iIKRubdWkj6bK0aE7HOfhQdN170dlf2R3T6B
	ak8RIWxga8DkBd1KXYtZHGu+dSbpW8GzWQxRBY+OlnEOR1+NOitmlaS4IMtAD2YJAqYswi
	Ayrv3CNj7OCfA27P3qrnhQpKy4H4NLtC9ZhtxyfRsmwQk7YCPcquTKHDUeCqGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9SjC7lUH+GkLlvOrY9vqVnXDja7uDl2cbhH+lMcz+k=;
	b=dKdxSWvUL2vSHStj9QNKFfW8RtFjjGcaGT95yQinVMBU5Rn3gBJE3mWpzLxC4qFno0pqB+
	DlB0ta21S8empPCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Split out the AUX buffer allocation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104019.494205648@infradead.org>
References: <20250812104019.494205648@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551254598.1420.9411382396633457171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2aee37682391332d26c01e703170e0d9358c7252
Gitweb:        https://git.kernel.org/tip/2aee37682391332d26c01e703170e0d9358=
c7252
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:13:00 +02:00

perf: Split out the AUX buffer allocation

Move the AUX buffer allocation branch into its own function.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104019.494205648@infradead.org
---
 kernel/events/core.c | 144 ++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 67 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5bbea81..e76afd9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6970,6 +6970,82 @@ static void perf_mmap_account(struct vm_area_struct *v=
ma, long user_extra, long=20
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
=20
+static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *even=
t,
+			 unsigned long nr_pages)
+{
+	long extra =3D 0, user_extra =3D nr_pages;
+	u64 aux_offset, aux_size;
+	struct perf_buffer *rb;
+	int ret, rb_flags =3D 0;
+
+	rb =3D event->rb;
+	if (!rb)
+		return -EINVAL;
+
+	guard(mutex)(&rb->aux_mutex);
+
+	/*
+	 * AUX area mapping: if rb->aux_nr_pages !=3D 0, it's already
+	 * mapped, all subsequent mappings should have the same size
+	 * and offset. Must be above the normal perf buffer.
+	 */
+	aux_offset =3D READ_ONCE(rb->user_page->aux_offset);
+	aux_size =3D READ_ONCE(rb->user_page->aux_size);
+
+	if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
+		return -EINVAL;
+
+	if (aux_offset !=3D vma->vm_pgoff << PAGE_SHIFT)
+		return -EINVAL;
+
+	/* already mapped with a different offset */
+	if (rb_has_aux(rb) && rb->aux_pgoff !=3D vma->vm_pgoff)
+		return -EINVAL;
+
+	if (aux_size !=3D nr_pages * PAGE_SIZE)
+		return -EINVAL;
+
+	/* already mapped with a different size */
+	if (rb_has_aux(rb) && rb->aux_nr_pages !=3D nr_pages)
+		return -EINVAL;
+
+	if (!is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	if (!atomic_inc_not_zero(&rb->mmap_count))
+		return -EINVAL;
+
+	if (rb_has_aux(rb)) {
+		atomic_inc(&rb->aux_mmap_count);
+
+	} else {
+		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+			atomic_dec(&rb->mmap_count);
+			return -EPERM;
+		}
+
+		WARN_ON(!rb && event->rb);
+
+		if (vma->vm_flags & VM_WRITE)
+			rb_flags |=3D RING_BUFFER_WRITABLE;
+
+		ret =3D rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
+				   event->attr.aux_watermark, rb_flags);
+		if (ret) {
+			atomic_dec(&rb->mmap_count);
+			return ret;
+		}
+
+		atomic_set(&rb->aux_mmap_count, 1);
+		rb->aux_mmap_locked =3D extra;
+	}
+
+	perf_mmap_account(vma, user_extra, extra);
+	atomic_inc(&event->mmap_count);
+
+	return 0;
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event =3D file->private_data;
@@ -7088,73 +7164,7 @@ static int perf_mmap(struct file *file, struct vm_area=
_struct *vma)
 		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
 	} else {
-		/*
-		 * AUX area mapping: if rb->aux_nr_pages !=3D 0, it's already
-		 * mapped, all subsequent mappings should have the same size
-		 * and offset. Must be above the normal perf buffer.
-		 */
-		u64 aux_offset, aux_size;
-
-		rb =3D event->rb;
-		if (!rb)
-			goto unlock;
-
-		guard(mutex)(&rb->aux_mutex);
-
-		aux_offset =3D READ_ONCE(rb->user_page->aux_offset);
-		aux_size =3D READ_ONCE(rb->user_page->aux_size);
-
-		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
-			goto unlock;
-
-		if (aux_offset !=3D vma->vm_pgoff << PAGE_SHIFT)
-			goto unlock;
-
-		/* already mapped with a different offset */
-		if (rb_has_aux(rb) && rb->aux_pgoff !=3D vma->vm_pgoff)
-			goto unlock;
-
-		if (aux_size !=3D nr_pages * PAGE_SIZE)
-			goto unlock;
-
-		/* already mapped with a different size */
-		if (rb_has_aux(rb) && rb->aux_nr_pages !=3D nr_pages)
-			goto unlock;
-
-		if (!is_power_of_2(nr_pages))
-			goto unlock;
-
-		if (!atomic_inc_not_zero(&rb->mmap_count))
-			goto unlock;
-
-		if (rb_has_aux(rb)) {
-			atomic_inc(&rb->aux_mmap_count);
-			ret =3D 0;
-
-		} else {
-			if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-				ret =3D -EPERM;
-				atomic_dec(&rb->mmap_count);
-				goto unlock;
-			}
-
-			WARN_ON(!rb && event->rb);
-
-			if (vma->vm_flags & VM_WRITE)
-				flags |=3D RING_BUFFER_WRITABLE;
-
-			ret =3D rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
-					   event->attr.aux_watermark, flags);
-			if (ret) {
-				atomic_dec(&rb->mmap_count);
-				goto unlock;
-			}
-
-			atomic_set(&rb->aux_mmap_count, 1);
-			rb->aux_mmap_locked =3D extra;
-		}
-		perf_mmap_account(vma, user_extra, extra);
-		atomic_inc(&event->mmap_count);
+		ret =3D perf_mmap_aux(vma, event, nr_pages);
 	}
=20
 unlock:

