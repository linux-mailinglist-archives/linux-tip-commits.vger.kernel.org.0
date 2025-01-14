Return-Path: <linux-tip-commits+bounces-3208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F0BA11310
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2025 22:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AFC166457
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2025 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F0212B24;
	Tue, 14 Jan 2025 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRfDQpPK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B0209F4C
	for <linux-tip-commits@vger.kernel.org>; Tue, 14 Jan 2025 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890221; cv=none; b=fDOA3VwVEgNenrp0EkVgrhQ0anDCYfzeKXZBOycf1BmQW1I1bQYREfkPcoo104AvHSEtxWE+HV60kB6tLyslRae4Pd+7DjNS+WY7FqzCxvLUjfStB6hAk1uB2R0dnrvYGS1E3T11dOCGKvFKEHy/Snw5ALDgckUA78aSuGEcOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890221; c=relaxed/simple;
	bh=IBL2FME9/iU7DT+aVY0Csc+9Yj4izcswBxjx8kmmpjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIuX0Rp20saBH++d+2WSG72cSVJ0pEZ9opaQLscilRBv1QR50eNF2uTEFyyoL6+VW8B246c+1oOytmv5CBPfRtp02aup+IU7wluMs29ZuZwfvGdfGo/SrgZ0guyCv0wnq8XrzwXbgMlUEUqKoxPVSrPKuehfFHHx4ab5/nESQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRfDQpPK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736890218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AVLJNeS0x1Rvdn41I2PgSlJlBnIKz4DVBkDUZI0/VE=;
	b=ZRfDQpPKdQEterSNVo3hWnEhDVKJAJ13n1umX0LjcZPFA0B7XUtZys6cXey85EyGOdXLV+
	TVVHFd4Ifq1av+g2efWvOdjwV/aV3gO8I6uDINKaP/srlRVOg+5nlRmrEmiCUPHvpCd4cC
	EWAES8SrT+aDItflBG4B27JOUGNQQD8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-_iOqXK5YMOiParZGKx6XLw-1; Tue,
 14 Jan 2025 16:30:14 -0500
X-MC-Unique: _iOqXK5YMOiParZGKx6XLw-1
X-Mimecast-MFC-AGG-ID: _iOqXK5YMOiParZGKx6XLw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CA5619560B9;
	Tue, 14 Jan 2025 21:30:13 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C65CF195608E;
	Tue, 14 Jan 2025 21:30:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 22:29:48 +0100 (CET)
Date: Tue, 14 Jan 2025 22:29:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: locking/core] cleanup, tags: Create tags for the cleanup
 primitives
Message-ID: <20250114212944.GB5051@redhat.com>
References: <20250106102647.GB20870@noisy.programming.kicks-ass.net>
 <173660167953.399.4769008465233152772.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173660167953.399.4769008465233152772.tip-bot2@tip-bot2>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 01/11, tip-bot2 for Peter Zijlstra wrote:
>
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -212,6 +212,13 @@ regex_c=(
>  	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
>  	'/^\<DECLARE_IDTENTRY[[:alnum:]_]*([^,)]*,[[:space:]]*\([[:alnum:]_]\+\)/\1/'
>  	'/^\<DEFINE_IDTENTRY[[:alnum:]_]*([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +	'/^\<DEFINE_FREE(\([[:alnum:]_]\+\)/cleanup_\1/'
> +	'/^\<DEFINE_CLASS(\([[:alnum:]_]\+\)/class_\1/'
> +	'/^\<EXTEND_CLASS(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]_]\+\)/class_\1\2/'
> +	'/^\<DEFINE_GUARD(\([[:alnum:]_]\+\)/class_\1/'
> +	'/^\<DEFINE_GUARD_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]_]\+\)/class_\1\2/'
> +	'/^\<DEFINE_LOCK_GUARD_[[:digit:]](\([[:alnum:]_]\+\)/class_\1/'
> +	'/^\<DEFINE_LOCK_GUARD_[[:digit:]]_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]_]\+\)/class_\1\2/'
>  )

Thanks ;)

I don't use scripts/tags.sh, but I will add these changes to my personal
scripts.

Oleg.


