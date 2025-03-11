Return-Path: <linux-tip-commits+bounces-4121-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1556CA5C42E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91C03ABA90
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Mar 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A81E4929;
	Tue, 11 Mar 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ+9EFx3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020F156C62;
	Tue, 11 Mar 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704480; cv=none; b=mEzAh4p6xxXl68VmlV3wrbDHcNpirnrXwDmc9adUffw7XfVeil0isb2ADsyBiCagK1mVLn6PYgQ5ZZ+40zV6BfPYNYgPWsBfu1vpeyPCdQr7fwkMS+G/uczhyFLzyCuvuOwGmczyWORbXKW0QCJyyQILJB/l38vZS3YD0EJStew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704480; c=relaxed/simple;
	bh=/qqmXuCsicGmaWXDoSyxoGv8hqbjwNj3Xot0VGAw2KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/wX7oKbT5Vz2ZoPsiWK6uI62ka0Y/irH7KyFPzv/MiRqkFJl+pshEXO/+ERB2Wd3f+T9kEuK7Y/kvmkKZzICXR58PTA5pXwwoeSbs7iSJpTL34jenRoTRF8xjbdgqPCXnG1pZ6cQgRKOxGWm/IOORO5JBNjQqdckTraATbrOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ+9EFx3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225477548e1so57281045ad.0;
        Tue, 11 Mar 2025 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741704478; x=1742309278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0fB/DOm5pGJdLj+lod0Jye4lpPApKncNUREZlt9PPU=;
        b=XJ+9EFx3EUUq7hEsP8NMaJN+j/bEWpaRsIwsgp2ZAViOEsJwOXoUM/IySLjBfrnepy
         VRmUZ0b5WoO9FYXBMF8SXbJo/zediH69E/DKG/n0W1IkVTCg8NOqCHxGIz0dVx3uRW88
         5EVpn0+fIQwFCwKwREy6xUXCmzRFj+uG5gaOQlxEFv+jFdqkBL1veJdd8rILg1TC6VPY
         AR4q8FW9mTn4Cvw6k4c13wo/tDT85msJpLvQ1HNrPjPz+HBuqyHHFd/GXXnjAvEG1S+A
         f4CGbVUISRojnkL/u/ap3+FQQyV6kidQJ/vHOCG/7p+8ovkCDHdAbvmY6XpW9h+qX3XP
         ZY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704478; x=1742309278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0fB/DOm5pGJdLj+lod0Jye4lpPApKncNUREZlt9PPU=;
        b=mRzz+jXVFZvn7de4gTrWCCXQEOaM7VzKTq0bpPjNjCk+aTJT0mHlZS0yvN/2/g00aD
         FmI1NylSSsE60nx2sjTzE6AUxle3gcInuC9oDBAaSMLJhvYJVFkjoBIa377yedVceZ0Z
         8RpT7X6/vHLzCZebdjyzJybsAQzxbHo+7xiczQGNmkPsvkCebuN74iEkCF4j249LB0UO
         CHG0AoZzK2671Mu2mmF/epR4SwAtWWFkfOR4lrM0ilQZ41P7zvfS1wy7Bu5YmdKxBUTg
         Ilr9/F9Bcf2UJuFYvoGl54bwFt3wE9pXEBVpucy7Mkkwzuib0lvYxce5wxmGlv7zn2p9
         N/eg==
X-Gm-Message-State: AOJu0YylTiFRSQSG/ZH3ZkvG+ARqzQQqOQaDjrJtqsE1I+qA+lyh3/L8
	WmHYnIfU9XRyw+02fET2VJyzXloMELCkc04g8MH5eEVb+tjBi2cElZSCBhdv
X-Gm-Gg: ASbGncvlWComdGSHHngUBsshS0ukEBJbJ0IB9m2Uud+2U07brtpq5r3GM7VBInTiTkE
	6hcrJiqyV6AhrYcd4/F+Duk9eLo6ExaZM9/w21g7i2Hw2XOAwNWHVEokx8lJg4wUPlPTVTBBZ6B
	2ePMpEhuC4VeEXBykQLhRL5Y0mSY7WVoGRNxV6i++uo1Q9fJyon1wV84ynowUPr+8vKRM/2WFrf
	H4tABVjJSt1QusKatDbF/EJ+E/4Wzq8puVQ0LfmDEMRm8zI/DT+jSADCbmElZfnFTCahesfjhGW
	MI1SX/zveDxnwEVCBL/WJyV5QZ+cWyXysDt0VMn4+DI98xXEQmdcWpMQ/Xk5W9nKumCzxLQH
X-Google-Smtp-Source: AGHT+IEMkC5xpqwXFIX/6MZvwrw4Yat06xd6qWvHjQyYhr8uiy45xXo577/idEpB4GH5j8gf9oJotw==
X-Received: by 2002:a17:902:e5c6:b0:223:4816:3e9e with SMTP id d9443c01a7336-22428899c52mr247468645ad.13.1741704477852;
        Tue, 11 Mar 2025 07:47:57 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91a8esm98827185ad.187.2025.03.11.07.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:47:57 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:47:53 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc: linux-tip-commits@vger.kernel.org, Yu-Chun Lin <eleanor15x@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [tip: x86/boot] x86/bootflag: Replace open-coded parity
 calculation with parity8()
Message-ID: <Z9BNGeZBh/6gJfHT@visitorckw-System-Product-Name>
References: <20250227125616.2253774-1-ubizjak@gmail.com>
 <174066211374.10177.8948394435153413345.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174066211374.10177.8948394435153413345.tip-bot2@tip-bot2>

Hi Ingo,

On Thu, Feb 27, 2025 at 01:15:13PM -0000, tip-bot2 for Kuan-Wei Chiu wrote:
> The following commit has been merged into the x86/boot branch of tip:
> 
> Commit-ID:     9c94c14ca39577b6324c667d8450ffa19fc1e5c4
> Gitweb:        https://git.kernel.org/tip/9c94c14ca39577b6324c667d8450ffa19fc1e5c4
> Author:        Kuan-Wei Chiu <visitorckw@gmail.com>
> AuthorDate:    Thu, 27 Feb 2025 13:55:45 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 27 Feb 2025 14:00:30 +01:00
> 
> x86/bootflag: Replace open-coded parity calculation with parity8()
> 
> Refactor parity calculations to use the standard parity8() helper. This
> change eliminates redundant implementations and improves code
> efficiency.
> 
> [ ubizjak: Updated the patch to apply to the latest x86 tree. ]
> 
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/r/20250227125616.2253774-1-ubizjak@gmail.com

Thanks for accepting this patch.

Based on the previous email discussion, I plan to rename parity8() to
parity_odd() in the next version of the parity patch series (though I'm
not too confident it will be accepted...). If I base the series on the
current linux-next tree, it might cause conflicts when other
maintainers apply it to their own trees. On the other hand, if I base
it on Linus's tree, it would conflict with the x86 tree.

I'm not sure which tree I should base the next version on. Since this
series touches multiple subsystems, the situation is a bit tricky.

Regards,
Kuan-Wei

