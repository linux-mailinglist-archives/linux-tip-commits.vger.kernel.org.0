Return-Path: <linux-tip-commits+bounces-3689-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C8A46B5C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2497A9436
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E32566EA;
	Wed, 26 Feb 2025 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JbJ9Wjw7"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CED254B0D
	for <linux-tip-commits@vger.kernel.org>; Wed, 26 Feb 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599218; cv=none; b=p2BIF5116SD3lQR8BgtS7GFT9VRDzB2Rh3xXUSTVsBvo1Fi6hpWZGieoUTsrU1Nq9e8ru+ty0Tsjfaos07uJrxjw56T80uC1eDPvIrZVUG+s7D0+uALSMrmqhZ6VuQUDnh2yldSVo2lGSfvABRszgfGflkmf6YbCQEENl2kb4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599218; c=relaxed/simple;
	bh=kmXsm0tu1kCQ1GFE0RiAQ4Mdk6NvP8QTIiy8MYMTOJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nX2o0cSFcT8iT7gTeedbOR7xAER9NS1NXUjDF5T3owtr5eC+dr91mjy3qKoPPWwF5Y7qsbJZGhYW8oMP4IYyOXcOsxblTa2mGqo4ibjZ/8pEumYIO1+R8EMwBV3572OHPeF/66V7imfOLStKPSmSV2oFvRiAilinaC9tYMBtluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JbJ9Wjw7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec111762bso21543266b.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 26 Feb 2025 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740599213; x=1741204013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aDq2bqWbHjLfc7ZX5wzS8caIXUgF6MrSjsLg41kQmUQ=;
        b=JbJ9Wjw7nZz9GkiBVUTvNWjiGIaAZot1Wb97jWoS31zp14taon+k28j3Z4hVbAIMW1
         1Aw+yren7/eUSko9AyT7QMjzN05XQkr8ZkXfCdE2mvt93fpWQna1Vk8waO1XVgJEAEHJ
         ML+R3zSIfrpavRWwzxYRz42e7L58ChP3LipCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599213; x=1741204013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDq2bqWbHjLfc7ZX5wzS8caIXUgF6MrSjsLg41kQmUQ=;
        b=txS4RV9pDUxbMeefW25qxgTSJEHjwgtWl5hyRpLo8jhautbaBnqFPvx2akCy5kJL8h
         X8UO8rKucCmNPcRlnBBJuHtxIng046gzUXaZ1EIZWYWyc04F1uW2Xz12cnQwuaf/1bF4
         kCmU978U59SSe7dD0Jeq2/fs5GU3Z+ETdcHROWKbQUfzcuhlcepakPaO+4/OjVYDNv3p
         iJV40UrF3KQwS3StQR9X1jFLIPiaJO1lq/QiPpElAK3W8nLUkn75h46goQwfsC+Ne8/1
         2Re0MlJ31Q4iwd0UjqHdEpvKrtS+Fac+smU1R5utgUv+B58vRbh1AosETmPTr4X4K6xC
         UMQg==
X-Forwarded-Encrypted: i=1; AJvYcCW6FYtNajcNmeEYzoPT2fEZ/sJofLfKuzv6Vr2L3QbjypUpZHMQtlEa26OPkCLCilci991MRIOUGMjzPegTD4xMMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8BLIDS2AqpwFQ3/P7zNLRY9SlS+8W0QyFXOKBHshX0D7fPH0
	UpzfeURv8xfBBCWit2VKMe4ep+OYtrwaTUon4cSTKTAPPg3M4KMDgGyyIOA6Lk0k629FiWb5w9N
	WNT/AXg==
X-Gm-Gg: ASbGncspBCaRs87A4nGWgNRwYbtRZNd66KnCIENISgO9RhLua+ATe3wYlKSKjF3mayJ
	D8c3pEBR6f6HkbMqiMcPqieLgJpaT7hyEnCR/T6o++dZOJEGi/RB35WmcBTCHZ6zlhe6OSPwiB5
	8w4qVkFqxTMoI1b0DiR6WHUVgfI9m27o8b/uF0ufFPSP4WIu87azzALnHPxovY49YSoiXFx5Cdo
	4VotH4nr6Up6HOMyZXsVdspuCIQDMXfTpeCh22/SqzelYtNMDhtLMYCBGcqeHIrTZbEeZZ0k9qg
	alUM3j6y0i0TBiYNQ3g4weLBqPhpj6XTTPEMg0aBr+Mq9Ru+z+ouebOBIr//nPdGJ0BL0C1Ubkg
	y
X-Google-Smtp-Source: AGHT+IF8ZCk08xKWu61p46dYsEm/F+bSi43516Gy9akvoleTCQFOjcOs1WAwYDl9/oyr4JmtI8753Q==
X-Received: by 2002:a17:907:2cc6:b0:ab6:d7c5:124 with SMTP id a640c23a62f3a-abeeef44d9bmr536352866b.43.1740599213073;
        Wed, 26 Feb 2025 11:46:53 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abef6196eebsm162826066b.161.2025.02.26.11.46.52
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:46:52 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso128709a12.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 26 Feb 2025 11:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIY1pi7dtF8EjeDM5N3j3DLP7FpKs+hPbxbpvJqNjDsDjpqmcw8Ffw6zTSOM/0LK7gRpcRxXTij5uOzbOjK4TnYg==@vger.kernel.org
X-Received: by 2002:a17:907:c407:b0:ab7:c893:fc80 with SMTP id
 a640c23a62f3a-abeeedd7806mr626760566b.24.1740599211884; Wed, 26 Feb 2025
 11:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com>
 <Z76APkysrjgHjgR2@casper.infradead.org> <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
 <Z76R6ESSwiYipQVn@casper.infradead.org> <CAHk-=whS1uq_4hEgkZJogv_HMhe_PJ-RyMs6E303_Pa+W0zx0A@mail.gmail.com>
 <Z77zNK7mRdjwILL7@gmail.com>
In-Reply-To: <Z77zNK7mRdjwILL7@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 11:46:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9D2AK01nqOTkgOmHX16RmJBAwixuauaG7vKfhEH7HKA@mail.gmail.com>
X-Gm-Features: AQ5f1Jrk6XsYr3MaK4Awbj7yu4VkLzSx6BA6s2x3ZGWN9f_Hpcj1UKc3WhiiBro
Message-ID: <CAHk-=wj9D2AK01nqOTkgOmHX16RmJBAwixuauaG7vKfhEH7HKA@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 02:56, Ingo Molnar <mingo@kernel.org> wrote:
>
> Is this explanation better?

Ack. Just making it clear that it's always kernel pages, never a user
address range makes it fine in my book,

       Linus

